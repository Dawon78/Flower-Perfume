<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
  <title>관리자 로그인</title>
  <script language="javascript" src="js_package.js"></script>
  <style>
    @font-face {
      font-family: 'BookkMyungjo-Bd';
      src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
      font-weight: 700;
      font-style: normal;
    }

    body {
      margin: 0;
      padding: 0;
      font-family: 'BookkMyungjo-Bd', serif;
      background: #f8f8f8 url('./image/allback.png') no-repeat bottom;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-wrapper {
      background: rgba(255, 255, 255, 0.95);
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
      width: 360px;
      max-width: 90%;
      text-align: center;
    }

    .login-wrapper h2 {
      font-size: 24px;
      margin-bottom: 30px;
      color: #333;
    }

    .form-group {
      margin-bottom: 20px;
      text-align: left;
    }

    .form-group label {
      display: block;
      margin-bottom: 6px;
      font-size: 14px;
      color: #444;
    }

    .form-group input {
      width: 100%;
      padding: 12px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 8px;
      box-sizing: border-box;
      background-color: #fdfdfd;
    }

    .login-btn {
      background-color: #333;
      color: white;
      font-size: 16px;
      border: none;
      padding: 12px;
      width: 100%;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-top: 10px;
    }

    .login-btn:hover {
      background-color: #555;
    }
  </style>
</head>

<body onload="login_focus()">
  <div class="login-wrapper">
    <h2>&lt;관리자 로그인&gt;</h2>
    <form name="login" method="post" action="manager_loginOK.jsp" target="_parent">
      <div class="form-group">
        <label for="id">관리자 ID</label>
        <input type="text" id="id" name="id">
      </div>
      <div class="form-group">
        <label for="pass">패스워드</label>
        <input type="password" id="pass" name="pass" onkeydown="onEnterSubmit()">
      </div>
      <button type="button" class="login-btn" onclick="login_check()">로그인</button>
    </form>
  </div>
</body>
</html>
