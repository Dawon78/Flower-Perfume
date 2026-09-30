<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    // 요청 파라미터 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");
    String refundIdStr = request.getParameter("refund_id");
    String newStatus = request.getParameter("refund_status");

    // 파라미터 출력 (디버그용 - 배포 시 삭제 가능)
    // out.println("action=" + action + "<br>");
    // out.println("refund_id=" + refundIdStr + "<br>");
    // out.println("refund_status=" + newStatus + "<br>");

    if ("change_status".equals(action)) {
        if (refundIdStr != null && !refundIdStr.trim().isEmpty() 
            && newStatus != null 
            && (newStatus.equals("환불 요청") || newStatus.equals("환불 중") || newStatus.equals("환불 완료"))) {
            
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.gjt.mm.mysql.Driver"); // MySQL 드라이버
                conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flower?useUnicode=true&characterEncoding=UTF-8", 
                    "multi", 
                    "abcd"
                );

                String sql = "UPDATE refund_request SET refund_status = ? WHERE refund_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, newStatus);
                pstmt.setInt(2, Integer.parseInt(refundIdStr));

                int updated = pstmt.executeUpdate();

                if (updated > 0) {
                    out.println("<script>alert('상태가 변경되었습니다.'); location.href=document.referrer;</script>");
                } else {
                    out.println("<script>alert('상태 변경에 실패했습니다.'); history.back();</script>");
                }

            } catch (Exception e) {
                out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
                if (conn != null) try { conn.close(); } catch (Exception ignored) {}
            }
        } else {
            out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>
