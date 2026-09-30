<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page contentType="text/html;charset=euc-kr" %>

<style>
  @font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
  }

  body {
    font-family: 'BookkMyungjo-Bd', serif;
    margin: 0;
    padding: 0;
  }

  .container {
    width: 100%;
    max-width: 900px;
    margin: 40px auto;
    background-color:#fafafa;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
  }

  h1 {
    text-align: center;
    font-size: 28px;
    color: black;
    margin-bottom: 30px;
  }

  form table {
    width: 100%;
    border-collapse: collapse;
  }

  form td {
    padding: 16px 10px;
    vertical-align: top;
    font-size: 15px;
    color: #333;
    border-bottom: 1px solid #eee;
  }

  form td:first-child {
    width: 25%;
    font-weight: bold;
    text-align: right;
    padding-right: 20px;
  }

  input[type="text"],
  input[type="number"],
  input[type="date"],
  select,
  textarea {
    width: 100%;
    padding: 12px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fafafa;
    box-sizing: border-box;
  }

  textarea {
    resize: vertical;
    min-height: 120px;
  }

  .form-btn-container {
    text-align: center;
    margin-top: 30px;
  }

  input[type="submit"],
  input[type="reset"],
  .go-to-manager-btn {
    padding: 12px 30px;
    font-size: 16px;
    margin: 8px;
    border: none;
    border-radius: 6px;
    background-color: #333;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  input[type="submit"]:hover,
  input[type="reset"]:hover,
  .go-to-manager-btn:hover {
    background-color: #555;
  }

  .go-to-manager-btn {
    text-decoration: none;
  }
</style>


<div class="container">
  <h1>상품 추가</h1>
  <form method="post" action="insertGoodsResult.jsp">
    <table>
      <tr>
        <td>상품번호</td>
        <td><input type="number" name="prdNo" required></td>
      </tr>
      <tr>
        <td>계절</td>
        <td>
          <select name="prdType">
            <option value="봄">봄</option>
            <option value="여름">여름</option>
            <option value="가을">가을</option>
            <option value="겨울">겨울</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>카테고리</td>
        <td>
          <select name="prdCategory">
            <option value="Perfume">Perfume</option>
            <option value="Diffuser">Diffuser</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>상품명</td>
        <td><input type="text" name="prdName" required></td>
      </tr>
      <tr>
        <td>이미지 경로</td>
        <td><input type="text" name="prdImg"></td>
      </tr>
      <tr>
        <td>상품가격</td>
        <td><input type="number" name="prdPrice" step="0.01" required></td>
      </tr>
      <tr>
        <td>재고수량</td>
        <td><input type="number" name="prdStock" required></td>
      </tr>
      <tr>
        <td>상품 출시일</td>
        <td><input type="date" name="prdDate" required></td>
      </tr>
      <tr>
        <td>상품설명</td>
        <td><textarea name="prdDescription"></textarea></td>
      </tr>
    </table>

    <div class="form-btn-container">
      <input type="submit" value="상품등록">
      <input type="reset" value="취소">
    </div>
  </form>

</div>
</div>
