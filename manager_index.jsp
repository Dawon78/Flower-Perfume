<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
  <title>꽃 관리자 모드</title>


  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'BookkMyungjo-Bd', serif;
      background-image: url('./image/allback.png');
      background-repeat: no-repeat;
      background-size: cover;     /* 화면에 꽉 차도록 */
      background-position: bottom; /* 중앙 정렬 */
      display: flex;
      flex-direction: column;
      min-height: 100vh;
	   width: 1920px;
    }

    header {
      background: black;
      color: white;
      padding: 60px;
      text-align: center;
      display: flex;
	   width: 1920px;
    }

    main {
      display: flex;
      flex: 1;
    }

aside.sidebar {
  width: 220px;
  background-color: rgba(198, 198, 198, 0.4); /* 배경만 투명도 적용 */
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 87px;
  
}

    .postit {
      background: #ffffff;
      padding: 15px;
      border-radius: 10px;
      box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
      font-size: 15px;
      cursor: pointer;
      text-align: center;
	    transition: transform 0.3s ease-in-out;
    }
	aside.sidebar .postit:hover {
  transform: scale(1.05); /* hover 시 1.05배 증가 */
}


    section.content {
      flex: 1;
      padding: 40px;
      overflow-y: auto;
    }

    .logo-container {
      text-align: center;
      margin-bottom: 30px;
    }

    .logo-container img {
      max-width: 200px;
    }

    footer {
      background: black;
      text-align: center;
      padding: 60px;
      font-size: 14px;
      color: white;
	  width: 1920px;
    }

    .header-link {
      color: white; /* 흰 글씨 */
      text-decoration: none; /* 밑줄 제거 */
      font-size: 20px; /* 글씨 크기 */
      cursor: pointer; /* 포인터 커서 */
    }

    .header-link:hover {
      color: #fffae3; /* hover 시 색상 변경 */
    }

.dashboard {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 고정 4개 */
  gap: 30px;
  margin: 30px auto;
  max-width: 1500px;
}

.stat-box {
  background-color: white;
  padding: 25px;
  border-radius: 12px;
  font-size: 24px;
  text-align: center; /* 텍스트 왼쪽 정렬 */
  height: 600px;
  overflow-y: auto; /* 내용이 많으면 스크롤 */
  display: flex;
  flex-direction: column;
        white-space: nowrap;  /* 줄 바꿈을 방지 */
    overflow-x: hidden;     /* 내용이 넘칠 경우 숨김 처리 */
    text-overflow: ellipsis; /* 넘친 부분에 "..."을 표시 */
}

.stat-box strong {
  font-size: 24px;
  color: #333;
  margin-bottom: 30px; /* 제목과 내용 사이에 여백 추가 */
}

.stat-box ul {
  list-style-type: none;
  text-align: left;
  padding: 0;
  margin: 0;
  overflow-y: auto;
  flex-grow: 1; /* 나머지 공간을 채우기 위한 설정 */
   overflow-x: hidden;
}

.stat-box ul li {
  padding: 10px;
  border-bottom: 1px solid #ccc;
   max-width: 100%
   overflow-x: hidden;
}

.stat-box .stat-title {
  font-size: 18px;
  font-weight: bold;
  color: #555;
  margin-bottom: 20px; /* 각 항목 제목과 내용 사이에 여백 */
}

.stat-box .stat-content {
  font-size: 16px;
  color: #333;
}

.stat-date {
  font-weight: bold;
  font-size: 18px;
  color: #333;
  margin-bottom: 15px;  /* 날짜와 상품명 사이에 여백 추가 */
}

.stat-info {

  font-size: 16px;
  color: #555;
  margin-left: 10px;
  margin-bottom: 15px;  /* 각 항목들 간의 간격을 추가 */
}


	@font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}


  </style>
</head>
<body>
  <header>
    <a href="manager_index.jsp" style="font-size: 30px; cursor: pointer;" class="header-link">[ 花 관리자 모드 ]</a>
    <div style="margin-left: 1400px; margin-top:10px; font-size: 18px; cursor: pointer;" onclick="location.href='logout.jsp'">로그아웃</div>
  </header>

  <main>
    <aside class="sidebar">
      <div class="postit" style="margin-top: 40px;" onclick="loadContent('member.jsp')">회원 관리</div>
      <div class="postit" onclick="loadContent('function.jsp')">주문 관리</div>
	  <div class="postit" onclick="loadContent('refund_history.jsp')">환불 처리 현황</div>
      <div class="postit" onclick="loadContent('Question.jsp')">문의 관리</div>
      <div class="postit" onclick="loadContent('manager_review.jsp')">리뷰 관리</div>
	  <div class="postit" onclick="loadContent('selectAllGoods.jsp')">상품 조회</div>
      <div class="postit" style="margin-bottom: 40px;" onclick="loadContent('insertGoods.jsp')">상품 추가</div>
    </aside>

<%
  String DB_URL = "jdbc:mysql://localhost:3306/flower";
  String DB_ID = "multi";
  String DB_PASSWORD = "abcd";

  Connection con = null;
  Statement stmt = null;
  ResultSet rs = null;

  int newMembers = 0;
  int newOrders = 0;
  int reviewCount = 0;
  int unansweredQuestions = 0;

  String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

  try {
      Class.forName("org.gjt.mm.mysql.Driver");
      con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
      stmt = con.createStatement();

      // 오늘 가입 회원 수
      rs = stmt.executeQuery("SELECT COUNT(*) FROM member WHERE DATE(joinDate) = '" + today + "'");
      if (rs.next()) newMembers = rs.getInt(1);
      rs.close();

      // 오늘 주문 수
      rs = stmt.executeQuery("SELECT COUNT(*) FROM orderinfo WHERE DATE(ordDate) = '" + today + "'");
      if (rs.next()) newOrders = rs.getInt(1);
      rs.close();

      // 전체 리뷰 수
      rs = stmt.executeQuery("SELECT COUNT(*) FROM review");
      if (rs.next()) reviewCount = rs.getInt(1);
      rs.close();

      // 오늘 문의 수
      rs = stmt.executeQuery("SELECT COUNT(*) FROM question WHERE DATE(questionDate) = '" + today + "'");
      if (rs.next()) unansweredQuestions = rs.getInt(1);
      rs.close();
%>

    <section class="content" id="content-area">
      <div class="logo-container">
        <img src="./logo/logo_black.png" alt="로고">
        <p>관리자 페이지에 오신 것을 환영합니다.</p>
      </div>

      <div class="dashboard">
        <!-- 최근 가입 내역 -->
 <div class="stat-box">
  <strong style="cursor:pointer;" onclick="loadContent('function.jsp')">최근 가입 내역</strong>
  <ul>
    <%
      rs = stmt.executeQuery("SELECT memId, memName, memSex, joinDate FROM member ORDER BY joinDate DESC LIMIT 20");
      while (rs.next()) {
    %>
      <li>
        <%
    java.sql.Timestamp joinDate = rs.getTimestamp("joinDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedJoinDate = sdf.format(joinDate);
%>
<span class="stat-date"><%= formattedJoinDate %></span><br>

        <span class="stat-info">아이디: <%= rs.getString("memId") %></span><br>
        <span class="stat-info">이름: <%= rs.getString("memName") %></span><br>
        <span class="stat-info">성별: <%= rs.getString("memSex") %></span>
      </li>
    <%
      }
      rs.close();
    %>
  </ul>
</div>


<!-- 최근 주문 내역 -->
<div class="stat-box">
  <strong style="cursor:pointer;" onclick="loadContent('member.jsp')">최근 주문 내역</strong>
<ul>
<%
rs = stmt.executeQuery(
  "(SELECT o.ordDate, o.ordNo, o.ordSender, o.orderReceiver, o.ordRcvAddress1, o.ordRcvAddress2, o.total, " +
  "        p.prdName AS productName " +
  " FROM (SELECT * FROM orderinfo ORDER BY ordDate DESC LIMIT 20) o " +
  " JOIN orderproduct op ON o.ordNo = op.ordNo " +
  " JOIN product p ON op.prdNo = p.prdNo) " +
  
  "UNION ALL " +
  
  "(SELECT o.ordDate, o.ordNo, o.ordSender, o.orderReceiver, o.ordRcvAddress1, o.ordRcvAddress2, o.total, " +
  "        c.cusName AS productName " +
  " FROM (SELECT * FROM orderinfo ORDER BY ordDate DESC LIMIT 20) o " +
  " JOIN custom_product cp ON o.ordNo = cp.ordNo " +
  " JOIN custom c ON cp.cusNo = c.cusNo) " +

  "ORDER BY ordDate DESC, ordNo"
);


  int lastOrdNo = -1;
  String firstPrdName = "";
  int productCount = 0;

  while (rs.next()) {
    int ordNo = rs.getInt("ordNo");

    if (ordNo != lastOrdNo) {
      // 이전 주문 마무리 출력
      if (lastOrdNo != -1) {
        if (productCount > 1) {
          out.print(" 외 " + (productCount - 1) + "개");
        }
        out.println("</span></li>");
      }

      // 새 주문 시작
      firstPrdName = rs.getString("productName");

      productCount = 1;
%>
  <li>
    <%
    java.sql.Timestamp ordDate = rs.getTimestamp("ordDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedOrdDate = sdf.format(ordDate);
%>
<span class="stat-date"><%= formattedOrdDate %></span><br>

    <span class="stat-info">주문 번호: <%= ordNo %></span><br>
    <span class="stat-info">주문자: <%= rs.getString("ordSender") %></span><br>
    <span class="stat-info">받는자: <%= rs.getString("orderReceiver") %></span><br>
    <span class="stat-info">주소: <%= rs.getString("ordRcvAddress1") %></span><br>
    <span class="stat-info">상세주소: <%= rs.getString("ordRcvAddress2") %></span><br>
    <span class="stat-info">총액: <%= String.format("%,d", rs.getInt("total")) %>원</span><br>

   <span class="stat-info">상품명: <%= firstPrdName %>

<%
      lastOrdNo = ordNo;
    } else {
      productCount++;
    }
  }

  // 마지막 주문 마무리 출력
  if (lastOrdNo != -1) {
    if (productCount > 1) {
      out.print(" 외 " + (productCount - 1) + "개");
    }
    out.println("</span></li>");
  }

  rs.close();
%>
</ul>

</div>


        <!-- 최근 리뷰 내역 -->
        <div class="stat-box">
          <strong style="cursor:pointer;" onclick="loadContent('manager_review.jsp')">최근 리뷰 내역</strong>
          <ul>
            <%
              rs = stmt.executeQuery(
                "SELECT r.reviewDate, r.content, r.star, p.prdName " +
                "FROM review r " +
                "JOIN product p ON r.prdNo = p.prdNo " +
                "ORDER BY r.reviewDate DESC " +
                "LIMIT 20"
              );
              while (rs.next()) {
            %>
              <li>
                <%
    java.sql.Timestamp reviewDate = rs.getTimestamp("reviewDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedReviewDate = sdf.format(reviewDate);
%>
<span class="stat-date"><%= formattedReviewDate %></span><br>

                <span class="stat-info">상품명: <%= rs.getString("prdName") %></span><br>
                <span class="stat-info">별점: <%= rs.getInt("star") %>점</span><br>
                <span class="stat-info">리뷰 내용: <%= rs.getString("content") %></span>
              </li>
            <%
              }
              rs.close();
            %>
          </ul>
        </div>

<!-- 최근 문의 내역 -->
<div class="stat-box">
  <strong style="cursor:pointer;" onclick="loadContent('Question.jsp')">최근 문의 내역</strong>
  <ul>
    <%
      rs = stmt.executeQuery("SELECT * FROM question ORDER BY questionDate DESC LIMIT 20");
      while (rs.next()) {
    %>
      <li>
        <%
    java.sql.Timestamp questionDate = rs.getTimestamp("questionDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedQuestionDate = sdf.format(questionDate);
%>
<span class="stat-date"><%= formattedQuestionDate %></span><br>

        <span class="stat-info">이름: <%= rs.getString("memName") %></span><br>
        <span class="stat-info">전화번호: <%= rs.getString("memPhone") %></span><br>
        <span class="stat-info">이메일: <%= rs.getString("memEmail") %></span><br>
        <span class="stat-info">상품 카테고리: <%= rs.getString("prdCategory") %></span><br>
        <span class="stat-info">상품명: <%= rs.getString("prdName") %></span><br>
        <span class="stat-info">문의 내용: <%= rs.getString("questionText") %></span>
      </li>
    <%
      }
      rs.close();
    %>
  </ul>
</div>

      </div>
    </section>

<%
  } catch (Exception e) {
      out.println("<p>오류 발생: " + e.getMessage() + "</p>");
  } finally {
      try {
          if (rs != null) rs.close();
          if (stmt != null) stmt.close();
          if (con != null) con.close();
      } catch (SQLException e) {
      }
  }
%>

  </main>

  <footer>
    ⓒ 2025 꽃 관리자 시스템 | All rights reserved.
  </footer>

  <script>
    function loadContent(page) {
      fetch(page)
        .then(response => response.blob())
        .then(blob => {
          const reader = new FileReader();
          reader.onload = function () {
            document.getElementById("content-area").innerHTML = reader.result;
          };
          reader.readAsText(blob, 'euc-kr');
        })
        .catch(error => {
          document.getElementById("content-area").innerHTML = "<p>페이지를 불러오는 데 실패했습니다.</p>";
          console.error("Error loading page:", error);
        });
    }
  </script>
</body>
</html>
	