<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html; charset=euc-kr" %>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = null;
    PreparedStatement pstmtRequest = null;
    PreparedStatement pstmtItem = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtPrdName = null;
    PreparedStatement pstmtCustomName = null;
    ResultSet rs = null;
    ResultSet rsCheck = null;
    ResultSet rsName = null;

    try {
        // 파라미터 수집
        String ordNoStr = request.getParameter("ordNo");
        String memId = request.getParameter("memId");
        String refundReason = request.getParameter("refund_reason");
        String refundAmountStr = request.getParameter("refund_amount");
        String bank = request.getParameter("bank");
        String accountHolder = request.getParameter("accountHolder");
        String accountNumber = request.getParameter("accountNumber");

        String[] prdNoArr = request.getParameterValues("prdNo");
        String[] prdQtyArr = request.getParameterValues("prdQty");
        String[] customPrdNoArr = request.getParameterValues("customPrdNo");
        String[] customQtyArr = request.getParameterValues("customQty");

        int ordNo = Integer.parseInt(ordNoStr);
        int refundAmount = Integer.parseInt(refundAmountStr);

        if ((prdNoArr != null && (prdQtyArr == null || prdQtyArr.length == 0))
            || (customPrdNoArr != null && (customQtyArr == null || customQtyArr.length == 0))) {
            out.println("<script>alert('상품 수량 정보가 누락되었습니다.'); history.back();</script>");
            return;
        }

        Class.forName("org.gjt.mm.mysql.Driver");
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        conn.setAutoCommit(false); // 트랜잭션 시작

        // ======= 환불 중복 요청 여부 확인 (상품별 체크) =======
        String checkItemSql = "SELECT prdNo, custom_prdNo FROM refund_item WHERE refund_id IN (" +
            "SELECT refund_id FROM refund_request WHERE ordNo = ? AND refund_status IN ('환불 요청', '환불 중', '환불 완료'))";

        pstmtCheck = conn.prepareStatement(checkItemSql);
        pstmtCheck.setInt(1, ordNo);
        rsCheck = pstmtCheck.executeQuery();

        java.util.Set<Integer> refundedPrdNos = new java.util.HashSet<>();
        java.util.Set<Integer> refundedCustomPrdNos = new java.util.HashSet<>();

        while (rsCheck.next()) {
            int prdNoVal = rsCheck.getInt("prdNo");
            if (!rsCheck.wasNull()) refundedPrdNos.add(prdNoVal);

            int customPrdNoVal = rsCheck.getInt("custom_prdNo");
            if (!rsCheck.wasNull()) refundedCustomPrdNos.add(customPrdNoVal);
        }
        rsCheck.close();
        pstmtCheck.close();

        // ======= 이미 환불 중인 상품 이름 조회용 쿼리 =======
        String getPrdNameSql = "SELECT prdName FROM product WHERE prdNo = ?";
        String getCustomPrdNameSql = "SELECT custom_prdName FROM custom_product WHERE custom_prdNo = ?";

        // 사용자 요청 상품 중 이미 환불 중인 상품 있는지 검사 + 이름 조회
        if (prdNoArr != null) {
            for (String prdStr : prdNoArr) {
                int prdNoVal = Integer.parseInt(prdStr);
                if (refundedPrdNos.contains(prdNoVal)) {
                    pstmtPrdName = conn.prepareStatement(getPrdNameSql);
                    pstmtPrdName.setInt(1, prdNoVal);
                    rsName = pstmtPrdName.executeQuery();
                    String prdName = "알 수 없는 상품";
                    if (rsName.next()) {
                        prdName = rsName.getString("prdName");
                    }
                    rsName.close();
                    pstmtPrdName.close();

                    out.println("<script>alert('이미 환불 요청된 일반 상품이 포함되어 있습니다: " + prdName + "'); history.back();</script>");
                    return;
                }
            }
        }
        if (customPrdNoArr != null) {
            for (String customStr : customPrdNoArr) {
                int customPrdNoVal = Integer.parseInt(customStr);
                if (refundedCustomPrdNos.contains(customPrdNoVal)) {
                    pstmtCustomName = conn.prepareStatement(getCustomPrdNameSql);
                    pstmtCustomName.setInt(1, customPrdNoVal);
                    rsName = pstmtCustomName.executeQuery();
                    String customPrdName = "알 수 없는 커스텀 상품";
                    if (rsName.next()) {
                        customPrdName = rsName.getString("custom_prdName");
                    }
                    rsName.close();
                    pstmtCustomName.close();

                    out.println("<script>alert('이미 환불 요청된 커스텀 상품이 포함되어 있습니다: " + customPrdName + "'); history.back();</script>");
                    return;
                }
            }
        }
        // ================================================

        // ======= 환불 상품 요약 문자열 생성 =======
        StringBuilder refundProductsSummary = new StringBuilder();
        if (prdNoArr != null) {
            for (int i = 0; i < prdNoArr.length; i++) {
                String qty = (prdQtyArr != null && prdQtyArr.length > i) ? prdQtyArr[i] : "0";
                refundProductsSummary.append("prdNo:").append(prdNoArr[i]).append("(").append(qty).append("개),");
            }
        }
        if (customPrdNoArr != null) {
            for (int i = 0; i < customPrdNoArr.length; i++) {
                String qty = (customQtyArr != null && customQtyArr.length > i) ? customQtyArr[i] : "0";
                refundProductsSummary.append("customPrdNo:").append(customPrdNoArr[i]).append("(").append(qty).append("개),");
            }
        }
        if (refundProductsSummary.length() > 0) {
            refundProductsSummary.setLength(refundProductsSummary.length() - 1); // 마지막 쉼표 제거
        }

        // ======= refund_request 테이블 저장 =======
       String sqlRequest = "INSERT INTO refund_request(ordNo, memId, refund_reason, refund_amount, refund_status, refund_products, bank, account_holder, account_number) VALUES (?, ?, ?, ?, '환불 요청', ?, ?, ?, ?)";

        pstmtRequest = conn.prepareStatement(sqlRequest, Statement.RETURN_GENERATED_KEYS);
        pstmtRequest.setInt(1, ordNo);
        pstmtRequest.setString(2, memId);
        pstmtRequest.setString(3, refundReason);
        pstmtRequest.setInt(4, refundAmount);
        pstmtRequest.setString(5, refundProductsSummary.toString());
        pstmtRequest.setString(6, bank);
        pstmtRequest.setString(7, accountHolder);
        pstmtRequest.setString(8, accountNumber);

        int affectedRows = pstmtRequest.executeUpdate();
        if (affectedRows == 0) throw new SQLException("환불 요청 저장 실패");

        rs = pstmtRequest.getGeneratedKeys();
        int refundId = 0;
        if (rs.next()) {
            refundId = rs.getInt(1);
        } else {
            throw new SQLException("환불 요청 ID 생성 실패");
        }

        // ======= refund_item 테이블 저장 =======
        String sqlItem = "INSERT INTO refund_item(refund_id, prdNo, custom_prdNo, quantity) VALUES (?, ?, ?, ?)";
        pstmtItem = conn.prepareStatement(sqlItem);

        if (prdNoArr != null) {
            for (int i = 0; i < prdNoArr.length; i++) {
                int prdNoVal = Integer.parseInt(prdNoArr[i]);
                int qty = Integer.parseInt(prdQtyArr[i]);
                if (qty <= 0) continue;

                pstmtItem.setInt(1, refundId);
                pstmtItem.setInt(2, prdNoVal);
                pstmtItem.setNull(3, Types.INTEGER);
                pstmtItem.setInt(4, qty);
                pstmtItem.addBatch();
            }
        }

        if (customPrdNoArr != null) {
            for (int i = 0; i < customPrdNoArr.length; i++) {
                int customPrdNoVal = Integer.parseInt(customPrdNoArr[i]);
                int qty = Integer.parseInt(customQtyArr[i]);
                if (qty <= 0) continue;

                pstmtItem.setInt(1, refundId);
                pstmtItem.setNull(2, Types.INTEGER);
                pstmtItem.setInt(3, customPrdNoVal);
                pstmtItem.setInt(4, qty);
                pstmtItem.addBatch();
            }
        }

        pstmtItem.executeBatch();
        conn.commit();

        // ======= 성공 메시지 및 팝업 닫기 =======
        out.println("<script>");
        out.println("alert('환불 요청이 정상 처리되었습니다.');");
        out.println("if (window.opener) { window.opener.location.reload(); }");
        out.println("window.close();");
        out.println("</script>");

    } catch(Exception e) {
        if (conn != null) try { conn.rollback(); } catch(SQLException se) {}
        e.printStackTrace();

        out.println("<h3>환불 처리 중 오류 발생!</h3>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (rsName != null) try { rsName.close(); } catch (SQLException e) {}
        if (pstmtItem != null) try { pstmtItem.close(); } catch (SQLException e) {}
        if (pstmtRequest != null) try { pstmtRequest.close(); } catch (SQLException e) {}
        if (pstmtCheck != null) try { pstmtCheck.close(); } catch (SQLException e) {}
        if (pstmtPrdName != null) try { pstmtPrdName.close(); } catch (SQLException e) {}
        if (pstmtCustomName != null) try { pstmtCustomName.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
