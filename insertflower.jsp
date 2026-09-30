<%@ page contentType="text/html;charset=euc-kr" %>
<html>
<head><title>꽃 정보 등록</title></head>
<body>
<center>
<font color="blue" size="6"><b>[꽃 정보 등록]</b></font>
<form method="post" action="insertFlowerResult.jsp">
<table border="2" cellpadding="10" style="font-size:10pt;font-family:맑은 고딕">
    <tr>
        <td>상품번호 (prdNo) :</td>
        <td><input type="number" name="prdNo" required></td>
    </tr>
    <tr>
        <td>꽃 이름 (flowerName) :</td>
        <td><input type="text" name="flowerName" required></td>
    </tr>
    <tr>
        <td>꽃 부제목 (flowerSub) :</td>
        <td><input type="text" name="flowerSub"></td>
    </tr>
    <tr>
        <td>꽃말 (flowerMeaning) :</td>
        <td><input type="text" name="flowerMeaning" required></td>
    </tr>
    <tr>
        <td>꽃말 추가설명 (flowerSubMeaning) :</td>
        <td><input type="text" name="flowerSubMeaning"></td>
    </tr>
    <tr>
        <td>꽃말 상세추가 (flowerMeaningmore) :</td>
        <td><input type="text" name="flowerMeaningmore"></td>
    </tr>
    <tr>
        <td>꽃 설명 (flowerDescription) :</td>
        <td><input type="text" name="flowerDescription" required></td>
    </tr>
    <tr>
        <td>꽃 이미지 경로 1 (flowerImage1) :</td>
        <td><input type="text" name="flowerImage1"></td>
    </tr>
    <tr>
        <td>꽃 이미지 경로 2 (flowerImage2) :</td>
        <td><input type="text" name="flowerImage2"></td>
    </tr>
    <tr>
        <td>꽃 이미지 경로 3 (flowerImage3) :</td>
        <td><input type="text" name="flowerImage3"></td>
    </tr>
</table>
<p>
<input type="submit" value="꽃 정보 등록">
<input type="reset" value="취소">
</form>
</center>
</body>
</html>
