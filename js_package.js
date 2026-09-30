
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  order.jsp 및 directOrder.jsp 내에서 사용되는 자바스크립트 코드의 시작부
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function check_val()             // 주문서의 미입력항목 부분을 체크하는 자바스크립트 함수
{
	if (document.form.memTel.value == "") 
	{
		alert("주문자 전화번호는 반드시 기입을 해야 합니다. ");
		document.form.memTel.focus();
		return false;			
	}			

	if (document.form.receiver.value == "") 
	{
		alert("수령인 성명은 반드시 기입을 해야 합니다. ");
		document.form.receiver.focus();
		return false;			
	}

	if (document.form.rcvAddress.value == "") 
	{
		alert("수령인 주소는 반드시 기입을 해야 합니다. ");
		document.form.rcvAddress.focus();
		return false;			
	}

	if (document.form.rcvPhone.value == "") 
	{
		alert("수령인 전화번호는 반드시 기입을 해야 합니다. ");
		document.form.rcvPhone.focus();
		return false;			
	}
 
	if (document.form.cardNo.value == "" && document.form.bank.value == 0 ) 
	{
		alert("결제방법 중 하나는 선택해야 합니다. ");
		document.form.cardNo.focus();
		return false;			
	}

    	if (document.form.cardNo.value != "" && document.form.bank.value != 0 ) 
	{
		alert("결제방법 중 하나만 선택해야 합니다. ");
		document.form.cardNo.focus();
		return false;			
	}

	if (document.form.cardNo.value != "" && document.form.cardPass.value == "" ) 
	{
		alert("카드 비밀번호는 반드시 기입을 해야 합니다. ");
		document.form.cardNo.focus();
		return false;			
	}

   	document.form.submit();
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  order.jsp 및 directOrder.jsp 내에서 사용되는 자바스크립트 코드의 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  insertMember.jsp 내에서 사용되는 자바스크립트 코드의 시작부
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function checkID() {  
    var id = document.getElementById("memId").value; // 올바르게 ID 값을 가져오기

    if (id === "") {  // ID를 입력하지 않은 경우 알림
        alert("ID를 입력해 주세요!"); 
        document.getElementById("memId").focus(); 
        return; 
    }

    // 중복 검사용 팝업 띄우기
    window.open("checkId.jsp?id=" + encodeURIComponent(id), "win", 
                "width=255, height=145, scrollbars=no, resizable=no");
}




function checkValue()             // 회원가입폼에서 미입력한 항목이 있을 경우, 경고메시지를 보여주는 함수
{                                           
	if(newMem.id.value == "")     // if(document.newMem.id.value == "")라고 사용해도 동일함
    {
		alert("ID를 입력해 주세요!");  //  문자열이 포함된 경고창을 실행시킴
		newMem.id.focus();					//  작업의 포커스(커서)를 ID를 입력하는 텍스트필드로 이동시킴  
		return;                         //  함수의 실행을 종료함 ( "return false; " 라고 사용해도 동일함)
    }

    if(newMem.password.value == "") 
    {
		alert("비밀번호를 입력해 주세요!");
		newMem.password.focus();
		return;
    }

    if(newMem.name.value == "") 
    {
		alert("성명을 입력해 주세요!");
		newMem.name.focus();
		return;
    }

    if(newMem.joomin1.value == "") 
    {
		alert("주민등록번호 앞자리를 입력해 주세요!");
		newMem.joomin1.focus();
		return;
    }

    if(newMem.joomin2.value == "") 
    {
		alert("주민등록번호 뒷자리를 입력해 주세요!");
		newMem.joomin2.focus();
		return;
    }

    if(newMem.birthYear.value == "") 
    {
		alert("태어난 연도를 입력해 주세요!");
		newMem.birthYear.focus();
		return;
    }

    if(newMem.birthMonth.value == "") 
    {
		alert("태어난 달을 입력해 주세요!");
		newMem.birthMonth.focus();
		return;
    }

    if(newMem.birthDay.value == "") 
    {
		alert("태어난 날짜를 입력해 주세요!");
		newMem.birthDay.focus();
		return;
    }

    if(newMem.telephone.value == "") 
    {
		alert("전화번호를 입력해 주세요!");
		newMem.telephone.focus();
		return;
    }

    if(newMem.address.value == "") 
    {
		alert("주소를 입력해 주세요!");
		newMem.address.focus();
		return;
    }

	if(newMem.hp1.value == "") 
    {
		alert("휴대폰 앞자리 국번을 입력해 주세요!");
		newMem.hp1.focus();
		return;
    }

    if(newMem.hp2.value == "") 
    {
		alert("휴대폰 중간자리 번호를 입력해 주세요!");
		newMem.hp2.focus();
		return;
    }

    if(newMem.hp3.value == "") 
    {
		alert("휴대폰 끝자리 번호를 입력해 주세요!");
		newMem.hp3.focus();
		return;
    }

    newMem.submit();   // 입력한 값들을 모두 서버로 전송함 (전송버튼 클릭하는 것과 같은 효과)
}





function idFocus()        // 폼이 로딩되면  ID를 입력하는 위치에 바로 커서를 위치시켜놓는
{										// 자바스크립트 함수  (body 태그안의 onLoad 이벤트 핸들러에 주목할 것!)
	newMem.id.focus();
	return;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  insertMember.jsp 내에서 사용되는 자바스크립트 코드의 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  login.jsp 및 manager.html 내에서 사용되는 자바스크립트 코드의 시작부
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function login_check()      // 로그인시 미입력항목 부분을 체크해주는 자바스크립트 함수
{
	if(document.login.id.value=="")
	{
    	alert("아이디를 입력해 주세요.");
    	document.login.id.focus();
    	return;	
    }

    if(document.login.pass.value=="")
	{
    	alert("비밀번호를 입력해 주세요.");
    	document.login.pass.focus();			
    	return;
    }
		
    document.login.submit();
}



function onEnterSubmit()     // 로그인버튼을 클릭하지 않고, 엔터키를 입력하더라도 로그인 가능하게 해줌               
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  login.submit();    //  "keyCode==13"은 엔터키가 입력됨을 의미함
}
	

function login_focus()     // 폼이 로딩되면  ID를 입력하는 위치에 바로 커서를 위치시켜놓는
{											// 자바스크립트 함수  (body 태그안의 onLoad 이벤트 핸들러에 주목할 것!)
   	document.login.id.focus();
   	return;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  login.jsp 및 manager.html 내에서 사용되는 자바스크립트 코드의 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  viewDetailProduct.jsp 내에서 사용되는 자바스크립트 코드의 시작부
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function directOrd()        //  "즉시구매하기" 버튼을 클릭시 호출
{
	var str=product.qty.value;
	var frm = document.product;
	frm.action = "directOrder.jsp";
	frm.submit();
}
/*

function inCart()              //  "장바구니담기" 버튼을 클릭시 호출
{
	var str=product.qty.value;
	var frm = document.product;
	frm.action = "inCart.jsp";
	frm.submit();
}
*/

function enlarge()           //  상품이미지 클릭시 팝업창을 띄워주면서 이미지 표시
{
	var no = document.product.prdNo.value;
	window.open("./images/"+no+".jpg","win", "width=280, height=280, scrollbars=no, resizable=no");
}



function amountCheck()     //   주문수량에 유효한 값만 들어가도록 처리해 줌
{
	obj=document.product.qty;
	if(isNaN(obj.value))          //    isNaN(a)함수는 a가 숫자가 아닐 경우, true를 return해줌
	{
		obj.value="1";
		alert('숫자만 입력해주세요');
		return;
	}

   if(obj.value < 1)
	{
		obj.value="1";
	}
}


function amountPlus()         //   주문수량을 1 증가 시킴
{
	obj=document.product.qty;
	obj.value=parseInt(obj.value) + 1;
}


function amountMinus()        //   주문수량을 1 감소 시킴
{
	obj=document.product.qty;
	if(parseInt(obj.value)  > 1)
	{
		obj.value=parseInt(obj.value) - 1;
	}
	else
	{
		alert('더이상 줄일수가 없습니다');
		return;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  viewDetailProduct.jsp 내에서 사용되는 자바스크립트 코드의 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

