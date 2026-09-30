<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="./css/header_footer.css">
<script src="./js/header.js" defer></script>
    <style>
	body{
	  background-image: url('./image/allback.png');
		background-size: cover;      
	  background-repeat: no-repeat;
	}
        .container {
            width: 1200px;
            margin: 0 auto;
            padding: 80px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        h2 {
            color: #2980b9;
            margin-top: 40px;
        }

        section {
           
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
        
        }

        p {
            line-height: 1.6;
        }

  

  
		li {
  list-style: none;
}
.tab-buttons {
  text-align: center;
  margin-top: 50px;
  margin-bottom: 20px;
}

.tab-buttons button {
  background-color: #f0f0f0;
  border: none;
  padding: 10px 20px;
  margin: 0 10px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 100px;
}

.tab-buttons button.active {
  background-color: #2980b9;
  color: white;
}

    </style>
</head>
<body>
  <header class="header">
        <div class="icon-bar">
            <div class="icon-container">
              <div class="logo"><a href="./index.jsp"><img src="./logo/logo.png" alt="Logo"></a></div>
              <form action="search.jsp" method="get" accept-charset="EUC-KR">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="input-search">
                <button type="submit" class="search-button" style="display: none;"></button>
            </form>
       
             <a href="./cart.jsp"><img src="./icon/shopping-cart.png" class="header-icon"></a>
             <a href="./mypage_updatemember.jsp"><img src="./icon/profile-white.png" class="header-icon"></a>
                       <a href="./logout.jsp">Logout</a>
         
            </div>
            <button class="hamburger" id="hamburgerBtn">
               <img src="./icon/header__toggle.png" alt="">
            </button>
        </div>
        
        <div class="nav-bar">
           
            <div class="menu-container" id="menuContainer">
                <nav>
                    <ul class="menu">
                        <li class="menu-item">봄</li>
                        <li class="menu-item">여름</li>
                        <li class="menu-item">가을</li>
                        <li class="menu-item">겨울</li>
                        <li  class="menu-item">사계의 꽃</a></li>
                        <li class="menu-item">나만의 향수 공방</a></li>
                    </ul>
                    <div class="submenus" id="submenus">
                      <div class="submenu">
                        <a href="Spring_Perfume.jsp">향수</a>
                        <a href="Spring_diffuser.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Summer_Perfume.jsp">향수</a>
                        <a href="Summer_diffuser.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Autumn_Perfume.jsp">향수</a>
                        <a href="Autumn_diffuser.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Winter_Perfume.jsp">향수</a>
                        <a href="Winter_diffuser.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="flowersBook.jsp">사계 백과사전</a>
                      </div>
                      <div class="submenu">
                        <a href="my_perfume_notes.jsp">향수의 기본 구조</a>
                        <a href="custom1.jsp">향수 커스텀</a>
                      </div>
                    </div>
                
                </nav>
            </div>
        </div>
    </header>

<div class="container">
  <h1>개인정보처리 및 이용약관</h1>
  <div class="tab-buttons">
    <button onclick="showTab('terms')" id="btn-terms" class="active">개인정보처리방침</button>
    <button onclick="showTab('privacy')" id="btn-privacy">이용약관</button>
  </div>

  <section id="terms" class="tab-content">
  <section id="privacy-policy">
	   <h3>1. 개인정보의 처리 목적</h3>
<p>
(주)花(이하 “회사”라 합니다)은 다음의 목적을 위하여 개인정보를 처리하며, 다른 용도로는 이용하지 않습니다.
</p>
<ul>
  <li>고객 가입 의사 확인</li>
  <li> 고객에 대한 서비스 제공에 따른 본인 식별 및 인증</li>
  <li> 회원 자격 유지 및 관리</li>
  <li> 물품 또는 서비스의 공급 및 대금 결제</li>
  <li> 물품 또는 서비스의 배송</li>
</ul>

<h3>2. 개인정보의 처리 및 보유 기간</h3>
<p>
  ① 정보주체로부터 개인정보를 수집할 때 동의 받은 보유·이용 기간 또는 관련 법령에 따라 개인정보를 처리하고 보유합니다.
</p>
<ul>
  <li>② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.
    <ul>
      <li> 고객 가입 및 관리: 카카오싱크를 통한 회원가입 및 카카오채널을 통한 관리</li>
      <li> 보유 기간: 카카오채널 탈퇴 시 즉시 삭제</li>
    </ul>
  </li>
</ul>

<h3>3. 정보주체와 법정대리인의 권리·의무 및 그 행사방법</h3>
<p>
  이용자는 개인정보 주체로서 언제든지 다음과 같은 권리를 행사할 수 있습니다.
</p>
<ul>
  <li>① 정보주체는 ‘’에 대해 다음 각 호의 권리를 행사할 수 있습니다.
    <ul>
      <li>1. 개인정보 열람 요구</li>
      <li>2. 오류 등이 있을 경우 정정 요구</li>
      <li>3. 삭제 요구</li>
      <li>4. 처리 정지 요구</li>
    </ul>
  </li>
</ul>

<h3>4. 처리하는 개인정보의 항목</h3>
<p>
  ① 회원 가입 및 고객 문의 시 다음과 같은 개인정보를 수집합니다.
</p>
<ul>
  <li>
    <strong>&lt;회원 가입 시 (회원)&gt;</strong>
    <ul>
      <li> 필수항목: 이름, 이메일, 전화번호, 성별, 연령대,  생년월일</li>
      <li>수집목적: 회원관리 및 마케팅 이용</li>
      <li> 보유기간: 회원 탈퇴 또는 동의 철회 시 지체없이 파기</li>
    </ul>
  </li>
  <li>
    <strong>&lt;고객 문의 시 (회원)&gt;</strong>
    <ul>
      <li> 필수항목: 문의종류, 이메일, 문의사항</li>
      <li> 수집목적: 고객 문의 및 상담 요청에 대한 회신, 상담 이력 확인</li>
      <li> 보유기간: 문의 접수 후 2년 간 보관 (단, 관계 법령에 따라 달라질 수 있음)</li>
    </ul>
  </li>
  <li>
 
<p>
  ② 만 14세 미만 아동의 개인정보를 보호하기 위하여, 만 14세 이상만 회원가입이 가능하도록 하며 아동의 개인정보는 수집하지 않습니다.
</p>
<h3>5. 개인정보의 파기</h3>
<p>
  원칙적으로 개인정보 처리 목적이 달성된 경우 지체 없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.
</p>
<ul>
  <li><strong> 파기 절차</strong><br>
    이용자가 입력한 정보는 목적 달성 후 별도의 DB로 옮겨져(종이의 경우 별도 문서) 내부 방침 및 기타 관련 법령에 따라 일정 기간 저장된 후 또는 즉시 파기됩니다. 이때 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니면 다른 목적으로 이용되지 않습니다.
  </li>
  <li><strong> 파기 기한</strong><br>
    개인정보의 보유 기간이 경과된 경우에는 보유 기간 종료일로부터 5일 이내에, 개인정보 처리 목적이 달성되었거나 서비스 폐지, 사업 종료 등으로 인해 불필요하게 된 경우에는 불필요하다고 인정되는 날로부터 5일 이내에 파기합니다.
  </li>
</ul>

<h3>6. 개인정보 처리방침 변경</h3>
<p>
  ① 본 개인정보처리방침은 시행일부터 적용되며, 법령이나 내부 정책 변경 시에는 변경사항을 최소 7일 전부터 홈페이지 공지사항을 통해 고지합니다.
</p>

<h3>7. 개인정보의 안전성 확보 조치</h3>
<p>
  「개인정보 보호법」 제29조에 따라 다음과 같은 안전성 확보 조치를 하고 있습니다.
</p>
<ul>
  <li>① <strong>개인정보 취급 직원의 최소화 및 교육</strong><br>
    개인정보를 취급하는 직원을 지정하여 최소화하고, 정기적인 교육을 시행합니다.
  </li>
  <li>② <strong>해킹 등에 대비한 기술적 대책</strong><br>
    보안 프로그램 설치 및 주기적인 갱신·점검을 통해 개인정보 유출 방지. 접근 제한 구역 내 시스템 설치 및 감시.
  </li>
  <li>③ <strong>개인정보의 암호화</strong><br>
    비밀번호는 암호화되어 저장되며, 중요 데이터는 암호화 및 파일 잠금 기능을 통해 보호됩니다.
  </li>
  <li>④ <strong>접속기록의 보관 및 위변조 방지</strong><br>
    개인정보처리시스템 접속 기록을 6개월 이상 보관하며, 위변조·도난·분실 방지를 위한 보안기능 사용.
  </li>
  <li>⑤ <strong>개인정보에 대한 접근 제한</strong><br>
    접근 권한 부여·변경·말소를 통해 통제하고, 침입 차단 시스템을 이용하여 외부 접근을 제한합니다.
  </li>
</ul>

   </section>
  </section>

  <section id="privacy" class="tab-content" style="display: none;">
      <section id="privacy-policy">
   
    <h2>제 1 장 총칙</h2>

      <h3>제 1 조 (목적)</h3>
      <p>
        본 약관은 (주)花(이하 “회사”라 합니다)이 운영하는 웹사이트 ‘花’ (이하 “웹사이트”라 합니다)에서 제공하는 온라인 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버몰과 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
      </p>

      <h3>제 2 조 (용어의 정의)</h3>
      <p>본 약관에서 사용하는 용어는 다음과 같이 정의한다.</p>
      <ul>
     <li>1. “웹사이트”란 회사가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.</li>
<li>2. “이용자”란 “웹사이트”에 접속하여 서비스를 이용하는 회원 및 비회원을 말합니다.</li>
<li>3. “회원”이라 함은 “웹사이트”에 개인정보를 제공하여 회원등록을 한 자로서, “웹사이트”의 정보를 지속적으로 제공받으며, “웹사이트”이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>
<li>4. “비회원”이라 함은 회원에 가입하지 않고, “웹사이트”이 제공하는 서비스를 이용하는 자를 말합니다.</li>
<li>5. “ID”라 함은 이용자가 회원가입 당시 등록한 사용자 “개인이용문자”를 말합니다.</li>


      </ul>

      <h3>제 3 조 (약관의 공시 및 효력과 변경)</h3>
      <ul>
        <li>1. 본 약관은 회원가입 화면에 게시하여 공시하며 회사는 사정변경 및 영업상 중요한 사유가 있을 경우 약관을 변경할 수 있으며 변경된 약관은 공지사항을 통해 공시한다.</li>
        <li>2. 본 약관 및 차후 회사 사정에 따라 변경된 약관은 이용자에게 공시함으로써 효력을 발생한다.</li>
      </ul>

      <h3>제 4 조 (약관 외 준칙)</h3>
      <p>
        본 약관에 명시되지 않은 사항이 전기통신기본법, 전기통신사업법, 정보통신촉진법, ‘전자상거래등에서의 소비자 보호에 관한 법률’, ‘약관의 규제에 관한 법률’, ‘전자거래기본법’, ‘전자서명법’, ‘정보통신망 이용촉진등에 관한 법률’, ‘소비자보호법’ 등 기타 관계 법령에 규정되어 있을 경우에는 그 규정을 따르도록 한다.
      </p>


  
      <h2>제 2 장 이용계약</h2>

      <h3>제 5 조 (이용신청)</h3>
      <ul>
        <li>1. 이용신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의 가입 신청서 작성)를 거쳐 ‘확인’ 버튼을 누르면 이용신청을 할 수 있다.</li>
        <li>2. 이용신청자는 반드시 실명과 실제 정보를 사용해야 하며 1개의 생년월일에 대하여 1건의 이용신청을 할 수 있다.</li>
        <li>3. 실명이나 실제 정보를 입력하지 않은 이용자는 법적인 보호를 받을 수 없으며, 서비스 이용에 제한을 받을 수 있다.</li>
      </ul>

      <h3>제 6 조 (이용신청의 승낙)</h3>
      <ul>
        <li>1. 회사는 제5조에 따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다.</li>
        <li>2. 회사는 아래 사항에 해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다.
          <ul>
            <li>가. 서비스 관련 설비에 여유가 없는 경우</li>
            <li>나. 기술상 지장이 있는 경우</li>
            <li>다. 기타 회사 사정상 필요하다고 인정되는 경우</li>
          </ul>
        </li>
        <li>3. 회사는 아래 사항에 해당하는 경우에 승낙을 하지 않을 수 있다.
          <ul>
            <li>가. 다른 사람의 명의를 사용하여 신청한 경우</li>
            <li>나. 이용자 정보를 허위로 기재하여 신청한 경우</li>
            <li>다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우</li>
            <li>라. 기타 회사가 정한 이용신청 요건이 미비한 경우</li>
          </ul>
        </li>
      </ul>
  
 
      <h2>제 3 장 계약 당사자의 의무</h2>

      <h3>제 7 조 (회사의 의무)</h3>
      <ul>
        <li>1. 회사는 사이트를 안정적이고 지속적으로 운영할 의무가 있다.</li>
        <li>2. 회사는 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정될 경우에는 즉시 처리해야 한다. 단, 즉시 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 공지사항 또는 전자우편을 통해 통보해야 한다.</li>
        <li>3. 제1항의 경우 수사상의 목적으로 관계기관 및 정보통신윤리위원회의 요청이 있거나 영장 제시가 있는 경우, 기타 관계 법령에 의한 경우는 예외로 한다.</li>
      </ul>

      <h3>제 8 조 (이용자의 의무)</h3>
      <ul>
        <li>1. 이용자는 본 약관 및 회사의 공지사항, 사이트 이용안내 등을 숙지하고 준수해야 하며 기타 회사의 업무에 방해되는 행위를 해서는 안된다.</li>
        <li>2. 이용자는 회사의 사전 승인 없이 본 사이트를 이용해 어떠한 영리행위도 할 수 없다.</li>
        <li>3. 이용자는 본 사이트를 통해 얻는 정보를 회사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 및 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.</li>
      </ul>

<h2>제 4 장 서비스의 제공 및 이용</h2>

      <h3>제 9 조 (서비스 이용)</h3>
      <ul>
        <li>1.	이용자는 본 약관의 규정된 사항을 준수해 사이트를 이용한다.</li>
        <li>2. 	본 약관에 명시되지 않은 서비스 이용에 관한 사항은 회사가 정해 ‘공지사항’에 게시하거나 또는 별도로 공지하는 내용에 따른다.</li>
   
      </ul>

<h3>제10조 (서비스 이용의 제한)</h3>
<p>본 사이트 이용 및 행위가 다음 각 호에 해당하는 경우 회사는 해당 이용자의 이용을 제한할 수 있다.</p>
<ul>
  <li>1. 공공질서 및 미풍양속, 기타 사회질서를 해하는 경우</li>
  <li>2. 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된다고 객관적으로 인정되는 경우</li>
  <li>3. 타인의 명예를 손상시키거나 타인의 서비스 이용을 현저히 저해하는 경우</li>
  <li>4. 타인의 의사에 반하는 내용이나 광고성 정보 등을 지속적으로 전송하는 경우</li>
  <li>5. 해킹 및 컴퓨터 바이러스 유포 등으로 서비스의 건전한 운영을 저해하는 경우</li>
  <li>6. 다른 이용자 또는 제3자의 지적재산권을 침해하거나 지적재산권자가 지적 재산권의 침해를 주장할 수 있다고 판단되는 경우</li>
  <li>7. 타인의 아이디 및 비밀번호를 도용한 경우</li>
  <li>8. 기타 관계 법령에 위배되는 경우 및 회사가 이용자로서 부적당하다고 판단한 경우</li>
</ul>

<h3>제11조 (서비스 제공의 중지)</h3>
<p>회사는 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부의 제공을 중지할 수 있다.</p>
<ul>
  <li>1. 전기통신사업법 상에 규정된 기간통신 사업자 또는 인터넷 망 사업자가 서비스를 중지했을 경우</li>
  <li>2. 정전으로 서비스 제공이 불가능할 경우</li>
  <li>3. 설비의 이전, 보수 또는 공사로 인해 부득이한 경우</li>
  <li>4. 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 어려운 경우</li>
  <li>5. 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우</li>
</ul>

<h3>제12조 (서비스 이용 책임)</h3>
<p>
  이용자는 회사에서 권한 있는 사원이 서명한 명시적인 서면에 구체적으로 허용한 경우를 제외하고는
  서비스를 이용하여 불법상품을 판매하는 영업활동을 할 수 없으며,
  특히 해킹, 돈벌기 광고, 음란 사이트를 통한 상업행위, 상용 S/W 불법제공 등을 할 수 없다.
  이를 어기고 발생한 영업활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는
  회사가 책임을 지지 않는다.
</p>
<h3>제13조 (결제방법)</h3>
<p>
  ‘회원’은 ‘회사’에서 판매하는 재화에 대하여 ‘선불카드, 직불카드, 신용카드 등의 각종 카드 결제 수단’을 이용하여 결제할 수 있다.
  이때 ‘회사’는 이용자의 지급방법에 대하여 재화 외 어떠한 명목의 수수료를 추가 징수하지 않는다.
</p>
<ul>
  <li>1. ‘회사’는 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 한다. 주문확인에 대한 내용은 해당 게시판에서 확인할 수 있다.</li>
  <li>2. 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고,
    ‘회사’는 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리한다.
    다만 이미 대금을 지불한 경우에는 제15조의 ‘환불 규정’을 따른다.
  </li>
</ul>

<h3>제14조 (배송정책)</h3>
<ul>
  <li>1. ‘회사’는 이용자와 재화의 공급 시기에 관하여 별도의 약정이 없는 이상, 이용자가 결제를 실시한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문 제작, 포장 등 기타의 필요한 조치를 취한다.</li>
  <li>2. ‘회사’는 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 제품을 구매하는 웹 페이지 하단에 명시한다.
    만약 ‘회사’가 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상한다.
    하지만 ‘회사’의 고의 또는 과실이 없음을 입증한 경우에는 그러하지 아니하다.
  </li>
</ul>

<h3>제15조 (취소 및 환불 규정)</h3>
<p>
  ‘회사’는 이용자가 구매 신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고,
  사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 한다.
</p>
<ul>
  <li>1. 재화가 발송되기 전 이용자가 결제를 취소할 경우 ‘회사’는 해당 주문건을 취소 처리하고 카드결제 승인을 취소한다.</li>
  <li>2. 재화가 발송된 이후 결제 취소는 불가하다.
    단, ‘회사’의 부주의 또는 배송상의 문제로 인한 재화의 파손, 변질의 경우 ‘회사’는 이용자에게 구매 금액의 환불 조치 및 조치를 취한다.
  </li>
</ul>
<h3>제16조 (면책 및 손해배상)</h3>
<ul>
  <li>1. 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 회사의 서비스 제공 책임이 면제된다.</li>
  <li>2. 회사는 이용자 간 또는 이용자와 제3자 간의 상호거래 관계에서 발생되는 결과에 대하여 어떠한 책임도 부담하지 않는다.</li>
  <li>3. 회사는 이용자가 게시판에 게재한 정보, 자료, 내용 등에 관하여 사실의 정확성, 신뢰도 등에 어떠한 책임도 부담하지 않으며 이용자는 본인의 책임 아래 본 사이트를 이용해야 한다.</li>
  <li>4. 이용자가 게시 또는 전송한 자료 등에 관하여 손해가 발생하거나 자료의 취사선택, 기타 무료로 제공되는 서비스 이용과 관련해 어떠한 불이익이 발생하더라도 이에 대한 모든 책임은 이용자에게 있다.</li>
  <li>5. 아이디와 비밀번호의 관리 및 이용자의 부주의로 인하여 발생되는 손해 또는 제3자에 의한 부정사용 등에 대한 책임은 이용자에게 있다.</li>
  <li>6. 이용자가 본 약관의 규정을 위반함으로써 회사에 손해가 발생하는 경우 이 약관을 위반한 이용자는 회사에 발생한 모든 손해를 배상해야 하며, 동 손해로부터 회사를 면책시켜야 한다.</li>
</ul>

<h3>제17조 (개인신용정보 제공 및 활용에 대한 동의서)</h3>
<p>
  회사가 회원 가입과 관련해 취득한 개인 신용 정보는 「신용정보의 이용 및 보호에 관한 법률」 제23조의 규정에 따라
  타인에게 제공 및 활용 시 이용자의 동의를 얻어야 한다.
  이용자의 동의는 회사가 회원으로 가입한 이용자의 신용정보를 신용정보기관, 신용정보업자 및 기타 이용자 등에게 제공해
  이용자의 신용을 판단하기 위한 자료로서 활용하거나 공공기관에서 정책자료로 활용하는 데 동의하는 것으로 간주한다.
</p>

<h3>제18조 (분쟁의 해결)</h3>
<ul>
  <li>1. 회사와 이용자는 본 사이트 이용과 관련해 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 해야 한다.</li>
  <li>2. 제1항의 규정에도 불구하고 동 분쟁으로 인하여 소송이 제기될 경우 동 소송은 회사의 본사 소재지를 관할하는 법원의 관할로 본다.</li>
</ul>

<p>&lt;부칙&gt;<br>
본 약관은 2020년 05월 1일부터 적용한다.
</p>
 	
      </section>
  </section>
</div>
  	   <footer class="footer">
    <div class="footer-container">
        <div class="footer-logo">
            <img src=".//logo/logo.png">
            <p>花은 계절 취향에 따라 이용자들의 취향을 파악하고, 취향에
                <br>맞는 향수와 디퓨저를 추천해 고객 니즈를 완벽히 파악하는<br>
                취지의 회사입니다.</p>
        </div>

        <div class="footer-links">
            <div class="footer-column col1">
                <h3>COMPANY</h3>
                <ul> 
                    <li><a href="./about.jsp" title="회사소개">About Us</a></li>
                    <li><a href="./terms_privacy.jsp" title="Terms and Privacy">Terms & Policy</a></li>

               <li><a href="./faq.jsp" title="자주 묻는 질문">FAQs</a></li>
                    <li><a href="./manager_login.jsp" title="관리자 로그인">Manager</a></li>
                </ul>
            </div>

            <div class="footer-column col3">
                <h3>CONTACT INFO</h3>
                <ul>
                    <li>Phone: 010-0000-0000</li>
                    <li>Email: flower@nsu.ac.kr</li>
                    <li>Location: Namseoul University</li>
                </ul>
                <div class="footer-social">
                    <a href="https://www.facebook.com" target="_blank" title="Facebook">
                        <img src="./icon/fb%20icon.png" alt="Facebook">
                    </a>
                    <a href="https://www.twitter.com" target="_blank" title="Twitter">
                        <img src="./icon/twitter%20icon.png" alt="Twitter">
                    </a>
                    <a href="https://www.instagram.com" target="_blank" title="Instagram">
                        <img src="./icon/insta%20icon.png" alt="Instagram">
                    </a>
                    <a href="https://www.linkedin.com" target="_blank" title="LinkedIn">
                        <img src="./icon/linkedin%20icoon.png" alt="LinkedIn">
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <p>ⓒ 2025 teamRockCrab | All rights reserved</p>
    </div>
</footer>
  <script>
  function showTab(tabId) {
    const tabs = document.querySelectorAll('.tab-content');
    const buttons = document.querySelectorAll('.tab-buttons button');

    tabs.forEach(tab => {
      tab.style.display = 'none';
    });

    buttons.forEach(btn => {
      btn.classList.remove('active');
    });

    document.getElementById(tabId).style.display = 'block';
    document.getElementById('btn-' + tabId).classList.add('active');
  }
</script>

</div>
