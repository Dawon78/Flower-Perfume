<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>향수 제출</title>
</head>
<body>
    <h1>향수 데이터 제출</h1>
    <p>선택한 메인 향: <%= request.getParameter("mainScent") %></p>
    <p>탑 노트: <%= request.getParameter("topNotes") %></p>
    <p>미들 노트: <%= request.getParameter("middleNotes") %></p>
    <p>베이스 노트: <%= request.getParameter("baseNotes") %></p>
</body>
</html>
