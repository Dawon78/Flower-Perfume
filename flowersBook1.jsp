<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.*, bean.Flower, bean.FlowerDAO" %>
<%
    FlowerDAO dao = new FlowerDAO();

    List<Flower> springFlowers = dao.getFlowersBySeason("봄");
    List<Flower> summerFlowers = dao.getFlowersBySeason("여름");
    List<Flower> autumnFlowers = dao.getFlowersBySeason("가을");
    List<Flower> winterFlowers = dao.getFlowersBySeason("겨울");

    dao.close();
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="./css/flowersBook.css">
    <link rel="stylesheet" href="./css/header_footer.css">
<script src="./js/flowersBook.js" defer></script>
<script src="./js/header__toggle.js" defer></script>
<script src="./js/header.js" defer></script>
</head>
<header class="header">
        <div class="icon-bar">
            <div class="icon-container">
              <div class="logo"><a href="./index.html"><img src="./logo/logo.png" alt="Logo"></a></div>
              <form action="search1.jsp" method="get" accept-charset="EUC-KR">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="input-search">
                <button type="submit" class="search-button" style="display: none;"></button>
            </form>
       
             
             <a href="./cart.jsp"><img src="./icon/shopping-cart.png" class="header-icon"></a>
             <a href="./mypage_updatemember.jsp"><img src="./icon/profile-white.png" class="header-icon"></a>
			 <a href="./login.jsp">Login</a>
         
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
                        <a href="Spring_Perfume1.jsp">향수</a>
                        <a href="Spring_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Summer_Perfume1.jsp">향수</a>
                        <a href="Summer_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Autumn_Perfume1.jsp">향수</a>
                        <a href="Autumn_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Winter_Perfume1.jsp">향수</a>
                        <a href="Winter_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="flowersBook1.jsp">사계 백과사전</a>
                      </div>
                      <div class="submenu">
                        <a href="my_perfume_notes1.jsp">향수의 기본 구조</a>
                        <a href="custom1.jsp">향수 커스텀</a>
                      </div>
                    </div>
                </nav>
            </div>
        </div>
    </header>

	<div id="content" class="content">
      <main>
        <div class="main_banner">
        </div>

<section class="flower-title"> 
    <p>꽃은 그 자체로 말을 하지 않지만, 우리가 느끼고 나누고 싶은 감정은 꽃을 통해 전해집니다.<br>각 꽃마다 그들만의 의미가 담겨 있고, 그 꽃말은 사람들의 마음속 깊은 곳에 자리 잡은 소중한 메세지입니다.</p>
</section>
<%
    request.setCharacterEncoding("euc-kr");

    String url = "jdbc:mysql://localhost:3306/flower";
    String user = "multi";
    String password = "abcd";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String selectedSeason = request.getParameter("season");
    if (selectedSeason == null) selectedSeason = "spring";

    String[] seasons = {"spring", "summer", "autumn", "winter"};
    int[][] ranges = {
        {1, 10}, 
        {11, 20},  
        {21, 30}, 
        {31, 40}   
    };
%>

<section>
    <div class="flowers">
        <p class="h2">사계 탄생화 카드</p>
        <p class="clickp">궁금한 꽃을 클릭해 보세요!</p>

<div class="season-filter">
<button onclick="filterSeason('spring')" data-season="spring" class="<%= selectedSeason.equals("spring") ? "spring active" : "spring" %>">봄</button>
<button onclick="filterSeason('summer')" data-season="summer" class="<%= selectedSeason.equals("summer") ? "summer active" : "summer" %>">여름</button>
<button onclick="filterSeason('autumn')" data-season="autumn" class="<%= selectedSeason.equals("autumn") ? "autumn active" : "autumn" %>">가을</button>
<button onclick="filterSeason('winter')" data-season="winter" class="<%= selectedSeason.equals("winter") ? "winter active" : "winter" %>">겨울</button>
</div>

        </button>

        <div class="slider-container">
            <div class="slider-wrapper" id="sliderWrapper">
                <%
				
                    for (int s = 0; s < seasons.length; s++) {
                        String season = seasons[s];
						
                        int start = ranges[s][0];
                        int end = ranges[s][1];
                        int count = 0;
                        boolean isOpen = false;
                %>
                <div class="season-slider <%= season %>" style="<%= selectedSeason.equals(season) ? "" : "display:none;" %>">

                    <%
                        try {
                            Class.forName("org.gjt.mm.mysql.Driver");
                            conn = DriverManager.getConnection(url, user, password);

                            String query = "SELECT * FROM flowerbook WHERE prdNo BETWEEN ? AND ? ORDER BY prdNo ASC";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setInt(1, start);
                            pstmt.setInt(2, end);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String prdNo = rs.getString("prdNo");
                                String flowerName = rs.getString("flowerName").replace("\"", "").trim();
                                String flowerSub = rs.getString("flowerSub").replace("\"", "").trim();
                                String flowerMeaning = rs.getString("flowerMeaning").replace("\"", "").trim();
                                String flowerSubMeaning = rs.getString("flowerSubMeaning").replace("\"", "").trim();
                                String flowerMeaningMore = rs.getString("flowerMeaningmore").replace("\"", "").trim();
                                String flowerDescription = rs.getString("flowerDescription").replace("\"", "").trim();
                                String flowerImage1 = rs.getString("flowerImage1");
                                String flowerImage2 = rs.getString("flowerImage2");
                                String flowerImage3 = rs.getString("flowerImage3");

                                if (count % 5 == 0) {
                                    if (isOpen) { %></div><% }
                    %>
                    <div class="slider">
                    <%
                                    isOpen = true;
                                }
                    %>
                        <div class="card"
                             style="background-image: url('<%= flowerImage1 %>');"
                             onclick='updateFlowerInfo(
                                 "<%= flowerImage1 %>", "<%= flowerImage2 %>", "<%= flowerImage3 %>",
                                 "<%= flowerName.replace("\"", "\\\"") %>", "<%= flowerSub.replace("\"", "\\\"") %>",
                                 "<%= flowerMeaning.replace("\"", "\\\"") %>", "<%= flowerSubMeaning.replace("\"", "\\\"") %>",
                                 "<%= flowerMeaningMore.replace("\"", "\\\"") %>", "<%= flowerDescription.replace("\"", "\\\"") %>")'>
                            <div class="title"><%= flowerName %></div>
                        </div>
                    <%
                                count++;
                            }
                            if (isOpen) { %></div><% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                            try { if (conn != null) conn.close(); } catch (Exception e) {}
                        }
                    %>
                </div>
                <% } %>
            </div>
        </div>
        </button>
    </div>
</section>

<div class="content1">
    <div class="image-section">
        <div class="large-image">
            <div class="large-left">
                <div class="large-image1"><img src="./image/1_1flower.png" id="img1"></div>
            </div>
            <div class="large-right">
                <div class="large-image2"><img src="./image/1_2flower.png" id="img2"></div>
                <div class="large-image3"><img src="./image/1_3flower.png" id="img3"></div>
            </div>
        </div>
    </div>

    <div class="text-section">
        <h2 id="flowerSub">하얗고 우아한 꽃</h2>
        <h2 id="flowerName">수선화</h2>
        <p id="flowerMeaning">수선화의 꽃말은 자존심, 자기애, 고결함입니다.</p>
        <p id="flowerSubMeaning">청초한 하얀 꽃잎과 함께 기품 있는 분위기를 풍깁니다.</p>
        <p id="flowerMeaningMore">스스로를 소중히 여기고 당당하게 살아가는 모습을 떠올리게 합니다.</p>
        <p id="flowerDescription">플로럴 하면서도 깨끗한 느낌을 주며, 부드러운 바람에 실려오는 향기로 우아하고 편안한 분위기를 선사합니다.</p>
		      <div class="header-buttons">
        <button class="view-all" onclick="viewAll()" style="margin-top:20px;">VIEW ALL</button>
      </div>
    </div>
</div>

<%
    // 1. 현재 날짜 정보 가져오기
    java.util.Calendar calendar = java.util.Calendar.getInstance();
    int month = calendar.get(java.util.Calendar.MONTH) + 1;
    int day = calendar.get(java.util.Calendar.DAY_OF_MONTH);
    int dayOfYear = calendar.get(java.util.Calendar.DAY_OF_YEAR); // 1년 중 몇 번째 날인지 (1~366)

    // 2. 탄생화 데이터 (총 54개)
    String[][] birthFlowers = {
        {"천남성(Arisaema)", "어둠 속에서도 꿋꿋이 피어나는 생명력과 신비로움을 지닌 꽃"},
        {"목련(Magnolia)", "고요한 품격과 순백의 순수함을 품은 봄의 전령"},
        {"물망초(Forget-me-not)", "언제까지나 나를 기억해 달라는 간절한 그리움의 상징"},
        {"박태기나무(Judas Tree)", "상처를 품고 피어나는 사랑의 용기와 희망의 전언"},
        {"배나무(Pear Tree)", "풍요와 정직함을 상징하는 순백의 약속"},
        {"명자꽃(Flowering Quince)", "화사한 아름다움 속에 숨겨진 절제된 감정과 사랑의 단아함"},
        {"꽃댕강나무(Abelia)", "소박한 정취 속에서 피어나는 변치 않는 우정"},
        {"살구(Apricot)", "풋풋한 첫사랑의 설렘과 봄 햇살 같은 따뜻함을 담은 꽃"},
        {"수양버들(Weeping Willow)", "바람에 춤추는 부드러운 강인함, 굴하지 않는 생명력"},
        {"아디안텀(Maidenhair Fern)", "고요하고 정제된 아름다움, 내면의 평온함을 상징하는 잎"},
        {"아이리스(Iris)", "신들의 전령처럼 희망의 메시지를 전하는 고결한 꽃"},
        {"월계수(Laurel)", "승리와 명예, 꿈을 향한 꾸준한 노력의 상징"},
        {"으름(Akebia)", "숨겨진 열정을 가진 이들의 사랑과 인내를 나타내는 꽃"},
        {"자작나무(Birch)", "순백의 껍질처럼 정직함과 고결한 의지를 지닌 나무"},
        {"전나무(Fir)", "영원한 생명과 희망을 상징하는 한겨울의 등불"},
        {"봄맞이꽃(Coltsfoot)", "찬 바람 속에서도 봄을 가장 먼저 알리는 용기의 꽃"},
        {"페튜니아(Petunia)", "다채로운 색처럼 감정을 솔직하게 표현하는 자유로운 영혼"},
        {"포플러(Poplar)", "높이 솟은 나무처럼 당당하고 흔들림 없는 의지를 가진 자"},
        {"한련화(Nasturtium)", "사랑을 감추며 자신을 희생하는 순정의 꽃"},
        {"동의나물(Anemone)", "작고 조용한 생명 속에 담긴 강한 의지와 치유의 힘"},
        {"회양목(Boxwood)", "절개와 신념을 지키며 살아가는 굳건한 의지의 나무"},
        {"민들레(Dandelion)", "바람에 실려도 다시 피어나는 자유와 회복의 상징"},
        {"돌단풍(Saxifrage)", "그늘 속에서도 잎을 물들이는 조용한 열정과 겸손한 아름다움"},
        {"금어초(Snapdragon)", "부드러움 속에 단단함을 품은 이중적인 매력의 꽃"},
        {"노랑무늬붓꽃(Yellow Iris)", "빛나는 개성으로 주변을 밝혀주는 존재감 있는 아름다움"},
        {"금잔화(Calendula)", "행복을 부르는 황금빛 미소와 따스한 애정의 꽃"},
        {"꽃아까시나무(Black Locust)", "진심 어린 환대와 포근한 인연을 품은 나무"},
        {"철쭉(Rhododendron)", "강렬한 사랑의 불꽃과 한결같은 마음을 담은 꽃"},
        {"당아욱(Mallow)", "상처를 감싸주는 치유와 부드러운 위로의 꽃"},
        {"루피너스(Lupine)", "다채로운 색으로 꿈과 이상을 향해 도전하는 모험가의 꽃"},
        {"칠엽수(Horse Chestnut)", "풍요로움과 행운, 가족애를 상징하는 포근한 나무"},
        {"모란(Peony)", "화려한 자태 속에 숨겨진 깊은 우아함과 위엄의 상징"},
        {"해당화(Rugosa Rose)", "진심 어린 사랑과 수줍은 고백을 품은 아름다운 꽃"},
        {"하늘나리(Tiger Lily)", "순수한 감성과 고결한 기품을 담은 신성한 꽃"},
        {"물푸레나무(Ash Tree)", "깊은 뿌리를 내려 삶을 지탱하는 지혜와 인내의 나무"},
        {"백합나무(Tulip Tree)", "은은한 향기처럼 조용한 감동을 주는 품격 있는 존재"},
        {"붓꽃(Iris)", "신성한 메시지를 전하며 영혼을 울리는 고요한 아름다움"},
        {"스타티스(Statice)", "영원히 변치 않는 기억과 함께하는 우정의 꽃"},
        {"개오동나무(Chinese Paulownia)", "성장을 돕는 그늘이 되어주는 따뜻한 보호자의 나무"},
        {"은방울꽃(Lily of the Valley)", "작고 맑은 종소리처럼 희망과 순결을 속삭이는 꽃"},
        {"작약(Peony)", "마음을 사로잡는 화려한 아름다움과 숨겨진 정열"},
        {"장미(Rose)", "사랑의 모든 감정을 노래하는 열정의 대명사"},
        {"용머리(Dragon's Head)", "독특한 생김새 속에 숨겨진 창조성과 강인한 생명력"},
        {"불두화(Snowball Viburnum)", "겉은 순백, 속은 깊은 정서를 품은 겸손의 꽃"},
        {"뻐꾹채(Silene)", "눈부신 여름의 문을 여는 낭만과 기다림의 상징"},
        {"산마늘(Mountain Garlic)", "자연의 깊은 품 안에서 피어난 순수함과 생명력"},
        {"대나무(Bamboo)", "굴하지 않는 강인함과 절개의 상징, 바른 삶을 뜻하는 나무"},
        {"찔레(Wild Rose)", "가시 뒤에 감춰진 순수한 사랑과 보호의 본능"},
        {"카네이션(Carnation)", "감사의 마음과 가족애를 전하는 따뜻한 정성의 꽃"},
        {"노루오줌(Thalictrum)", "은은하고 수줍은 아름다움이 주는 힐링의 메시지"},
        {"클레마티스(Clematis)", "희망을 타고 오르는 덩굴처럼 집념과 사랑을 전하는 꽃"},
        {"태산목(Southern Magnolia)", "고고한 자태 속에 담긴 인내와 위엄의 상징"},
        {"패랭이꽃(Pink)", "투박함 속의 진심, 순수한 사랑을 전하는 전통의 꽃"},
        {"플록스(Phlox)", "무리지어 피어나며 우정을 나누는 따뜻한 마음의 꽃"}
    };

    // 3. 인덱스 계산 로직 수정 (365일 대응)
    // 1년 중 오늘이 몇 번째 날인지(dayOfYear)를 활용하여 54개 꽃을 순환시킵니다.
    int flowerIndex = dayOfYear % birthFlowers.length;

    String flowerName = birthFlowers[flowerIndex][0];
    String flowerMeaning = birthFlowers[flowerIndex][1];
%>


<section class="today-flower-section"style="border-top:1px solid black; border-bottom:1px solid black; margin-left: 135px; margin-right: 135px;">
    <div class="flower-row">
      <div class="flower-image" style="margin-left:0px;">
        <img src="./image/todayflower1.png" alt="오늘의 꽃말사진">
      </div>
  
      <div class="flower-text">
        <div class="hashtag-name">
          <p class="hashtag">#오늘의 탄생화</p>
        </div>
		<p class="flower-name"><%= flowerName %></p>
        <p class="flower-meaning">
          "<%= flowerMeaning %>"
        </p>
      </div>
  
      <div class="flower-image">
        <img src="./image/todayflower2.png" alt="꽃 이미지2">
      </div>
    </div>
  </section>

<section class="content3">
  <section class="product-section">
    <div class="section-header">
      <h2>오늘의 계절별 상품 추천</h2>
      <div class="header-buttons">
        <button class="view-all" onclick="location.href='search1.jsp?query=플로럴'">VIEW ALL</button>
      </div>
    </div>
    <p class="section-header-p">다양한 계절별 패키지를 지금 花에서 만나보세요</p>

    <div class="slider-container">
      <div class="slider-wrapper">
<%


    String[] seasonLabels = {"봄", "여름", "가을", "겨울"};  
    int[][] productRanges = { 
        {1, 10, 41, 50},
        {11, 20, 51, 60},
        {21, 30, 61, 70},
        {31, 40, 71, 80}
    };

    try {

        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");

        java.util.Calendar cal = java.util.Calendar.getInstance();
        dayOfYear = cal.get(java.util.Calendar.DAY_OF_YEAR);
        java.util.Random rand = new java.util.Random(dayOfYear);

        for (int i = 0; i < seasonLabels.length; i++) { 
            String season = seasonLabels[i];  
            int[] range = productRanges[i]; 

            int selectedRange = rand.nextBoolean() ? 0 : 2;
            int start = range[selectedRange];
            int end = range[selectedRange + 1];
            int randomPrdNo = rand.nextInt(end - start + 1) + start;

            String sql = "SELECT prdNo, prdName, prdImg, prdPrice, prdDescription FROM product WHERE prdNo = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, randomPrdNo);
            rs = pstmt.executeQuery(); 

            if (rs.next()) {
                int prdNo = rs.getInt("prdNo");
                String prdName = rs.getString("prdName");
                String prdImg = rs.getString("prdImg") != null ? rs.getString("prdImg") : "./image/default.jpg";
                int prdPrice = rs.getInt("prdPrice");

%>
                <a href="Product_detail1.jsp?prdNo=<%= prdNo %>">
                    <div class="product-card">
                        <div class="season-label"><%= season %></div> 
                        <div class="img">
                            <img src="<%= prdImg %>" alt="<%= prdName %>">
                        </div>
                        <div class="product-in">
                            <div class="product-p">
                                <h3 class="product-title"><%= prdName %></h3>
                            </div>
                        </div>
                        <div class="product-price"><%= String.format("%,d", prdPrice) %>원</div>
                    </div>
                </a>
<%
            }

            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>


      </div>
    </div>
  </section>
</section>


    </main>


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
                    <li><a href="./about1.jsp" title="회사소개">About Us</a></li>
                    <li><a href="./terms_privacy1.jsp" title="Terms and Privacy">Terms & Policy</a></li>

               <li><a href="./faq1.jsp" title="자주 묻는 질문">FAQs</a></li>
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
	let selectedSeason = "spring";

function updateFlowerInfo(image1, image2, image3, name, sub, meaning, subMeaning, meaningMore, description) {
    console.log("updateFlowerInfo 함수 호출됨!");

    document.getElementById("img1").src = image1;
    document.getElementById("img2").src = image2;
    document.getElementById("img3").src = image3;

    document.getElementById("flowerName").innerText = name;
    document.getElementById("flowerSub").innerText = sub;
    document.getElementById("flowerMeaning").innerText = meaning;
    document.getElementById("flowerSubMeaning").innerText = subMeaning;
    document.getElementById("flowerMeaningMore").innerText = meaningMore;
    document.getElementById("flowerDescription").innerText = description;
}

function moveSlide(direction) {
    const currentSeason = document.querySelector(".season-slider[style*='flex']");
    if (!currentSeason) return;

    currentSeason.scrollBy({ left: direction * 600, behavior: 'smooth' });
}

const flowerData = {
    Spring: [
        <% for (int i = 0; i < springFlowers.size(); i++) { Flower f = springFlowers.get(i); %>{
            prdNo: "<%= f.getPrdNo() %>",
            flowerName: "<%= f.getFlowerName() %>",
            flowerSub: "<%= f.getFlowerSub() %>",
            flowerMeaning: "<%= f.getFlowerMeaning() %>",
            flowerSubMeaning: "<%= f.getFlowerSubMeaning() %>",
            flowerMeaningMore: "<%= f.getFlowerMeaningMore() %>",
            flowerDescription: "<%= f.getFlowerDescription() %>",
            flowerImage1: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage1()).getName() %>",
            flowerImage2: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage2()).getName() %>",
            flowerImage3: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage3()).getName() %>"
        }<%= i < springFlowers.size() - 1 ? "," : "" %><% } %>
    ],
    Summer: [
        <% for (int i = 0; i < summerFlowers.size(); i++) { Flower f = summerFlowers.get(i); %>{
            prdNo: "<%= f.getPrdNo() %>",
            flowerName: "<%= f.getFlowerName() %>",
            flowerSub: "<%= f.getFlowerSub() %>",
            flowerMeaning: "<%= f.getFlowerMeaning() %>",
            flowerSubMeaning: "<%= f.getFlowerSubMeaning() %>",
            flowerMeaningMore: "<%= f.getFlowerMeaningMore() %>",
            flowerDescription: "<%= f.getFlowerDescription() %>",
            flowerImage1: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage1()).getName() %>",
            flowerImage2: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage2()).getName() %>",
            flowerImage3: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage3()).getName() %>"
        }<%= i < summerFlowers.size() - 1 ? "," : "" %><% } %>
    ],
    Autumn: [
        <% for (int i = 0; i < autumnFlowers.size(); i++) { Flower f = autumnFlowers.get(i); %>{
            prdNo: "<%= f.getPrdNo() %>",
            flowerName: "<%= f.getFlowerName() %>",
            flowerSub: "<%= f.getFlowerSub() %>",
            flowerMeaning: "<%= f.getFlowerMeaning() %>",
            flowerSubMeaning: "<%= f.getFlowerSubMeaning() %>",
            flowerMeaningMore: "<%= f.getFlowerMeaningMore() %>",
            flowerDescription: "<%= f.getFlowerDescription() %>",
            flowerImage1: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage1()).getName() %>",
            flowerImage2: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage2()).getName() %>",
            flowerImage3: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage3()).getName() %>"
        }<%= i < autumnFlowers.size() - 1 ? "," : "" %><% } %>
    ],
    Winter: [
        <% for (int i = 0; i < winterFlowers.size(); i++) { Flower f = winterFlowers.get(i); %>{
            prdNo: "<%= f.getPrdNo() %>",
            flowerName: "<%= f.getFlowerName() %>",
            flowerSub: "<%= f.getFlowerSub() %>",
            flowerMeaning: "<%= f.getFlowerMeaning() %>",
            flowerSubMeaning: "<%= f.getFlowerSubMeaning() %>",
            flowerMeaningMore: "<%= f.getFlowerMeaningMore() %>",
            flowerDescription: "<%= f.getFlowerDescription() %>",
            flowerImage1: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage1()).getName() %>",
            flowerImage2: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage2()).getName() %>",
            flowerImage3: "<%= request.getContextPath() %>/Flower/image/<%= new java.io.File(f.getFlowerImage3()).getName() %>"
        }<%= i < winterFlowers.size() - 1 ? "," : "" %><% } %>
    ]
};

function renderAllSeasons() {
    const wrapper = document.getElementById("sliderWrapper");

    Object.keys(flowerData).forEach(season => {
        const seasonContainer = document.createElement("div");
        seasonContainer.className = `season-slider ${season}`;
        seasonContainer.style.display = "none"; 

        const flowers = flowerData[season];
        let sliderDiv = null;

        flowers.forEach((flower, index) => {
            if (index % 5 === 0) {
                sliderDiv = document.createElement("div");
                sliderDiv.className = "slider";
                seasonContainer.appendChild(sliderDiv);
            }

            const card = document.createElement("div");
            card.className = "card";
            card.style.backgroundImage = `url('${flower.flowerImage1}')`;
            card.onclick = () => {
                updateFlowerInfo(
                    flower.flowerImage1,
                    flower.flowerImage2,
                    flower.flowerImage3,
                    flower.flowerName,
                    flower.flowerSub,
                    flower.flowerMeaning,
                    flower.flowerSubMeaning,
                    flower.flowerMeaningMore,
                    flower.flowerDescription
                );
            };

            const title = document.createElement("div");
            title.className = "title";
            title.innerText = flower.flowerName;

            card.appendChild(title);
            sliderDiv.appendChild(card);
        });

        wrapper.appendChild(seasonContainer);
    });
}

function filterSeason(season) {
	selectedSeason = season; 
    const sliders = document.querySelectorAll(".season-slider");
    sliders.forEach(slider => {
        if (slider.classList.contains(season)) {
            slider.style.display = "flex";
        } else {
            slider.style.display = "none";
        }
    });

    const buttons = document.querySelectorAll(".season-filter button");
    buttons.forEach(btn => btn.classList.remove("active"));
    const activeBtn = document.querySelector(`.season-filter button.${season.toLowerCase()}`);
    if (activeBtn) activeBtn.classList.add("active");

    initSlider(season);
	
}


window.addEventListener("DOMContentLoaded", () => {
    renderAllSeasons();       
    filterSeason("spring");  
});

function viewAll() {
    switch (selectedSeason) {
        case 'spring':
            location.href = 'Spring_Product1.jsp';
            break;
        case 'summer':
            location.href = 'Summer_Product1.jsp';
            break;
        case 'autumn':
            location.href = 'Autumn_Product1.jsp';
            break;
        case 'winter':
            location.href = 'Winter_Product1.jsp';
            break;
    }
}
</script>

</body>
</html>