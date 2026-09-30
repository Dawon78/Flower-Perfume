<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/recipe.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/header.js" defer></script>
</head>
<body>
<%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
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

	<div class= "container">

        <h3>몇 가지 레시피를 소개할게요!</h3>
        <h4>계절별로 다양하게 향이 담겨있어요. 나만의 향으로 만드는 건 어떤가요?</h4>
        <section class="cards">
            <div class="cards__single spring card-bg">
              <div class="cards__front">
                <h1 class="cards__artist" tabindex="0">Spring Perfume</h1>
                <img class="cards__image" src="image/perfume2.png" alt="Bon Iver album" />
              </div>
              <div class="cards__back">
                <h2 class="recipe-title">Recipe</h2>
                <div class="notes">
                  <div class="note">
                    <span class="note-type1">TOP NOTES:</span>
                    <span class="note-value">벚꽃</span>
                    <span class="note-description">가볍고 달콤한 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type2">MIDDLE NOTES:</span>
                    <span class="note-value">튤립</span>
                    <span class="note-description">신선하고 생동감 넘치는 사과 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type3">BASE NOTES:</span>
                    <span class="note-value">머스크</span>
                    <span class="note-description">햇볕에 말린 깨끗한 이불 향</span>
                  </div>
                </div>
              </div>
            </div>
          
            <div class="cards__single summer card-bg">
              <div class="cards__front">
                <h1 class="cards__artist" tabindex="0">Summer Perfume</h1>
                <img class="cards__image" src="image/perfume16.png" alt="Guns N' Roses Album" />
              </div>
              <div class="cards__back">
                <h2 class="recipe-title">Recipe</h2>
                <div class="notes">
                  <div class="note">
                    <span class="note-type1">TOP NOTES:</span>
                    <span class="note-value">프리지아</span>
                    <span class="note-description">달콤하고 상큼한 오렌지 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type2">MIDDLE NOTES:</span>
                    <span class="note-value">장미</span>
                    <span class="note-description">풍부하고 달콤한 장미 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type3">BASE NOTES:</span>
                    <span class="note-value">라벤더</span>
                    <span class="note-description">시원하고 허브향이 나는 꽃 향</span>
                  </div>
                </div>
              </div>
            </div>
          
            <div class="cards__single autumn card-bg">
              <div class="cards__front">
                <h1 class="cards__artist" tabindex="0">Autumn Perfume</h1>
                <img class="cards__image" src="image/perfume24.png" alt="Arctic Monkeys album" />
              </div>
              <div class="cards__back">
                <h2 class="recipe-title">Recipe</h2>
                <div class="notes">
                  <div class="note">
                    <span class="note-type1">TOP NOTES:</span>
                    <span class="note-value">코스모스</span>
                    <span class="note-description">샴푸나 클렌징 폼에서 나는 은은한 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type2">MIDDLE NOTES:</span>
                    <span class="note-value">국화</span>
                    <span class="note-description">따뜻한 허브차에서 맡을 수 있는 은은한 꽃 향</span>
                  </div>
                  <div class="note">
                    <span class="note-type3">BASE NOTES:</span>
                    <span class="note-value">다알리아</span>
                    <span class="note-description">파우더룸에 퍼져 있는 고운 베이비파우더 향</span>
                  </div>
                </div>
              </div>
            </div>
          
            <div class="cards__single winter card-bg">
                <div class="cards__front">
                  <h1 class="cards__artist" tabindex="0">Winter Perfume</h1>
                  <img class="cards__image" src="image/perfume28.png" alt="Leon Bridges album" />
                </div>
                  <div class="cards__back">
                    <h2 class="recipe-title">Recipe</h2>
                    <div class="notes">
                      <div class="note">
                        <span class="note-type1">TOP NOTES:</span>
                        <span class="note-value">크리스마스 로즈</span>
                        <span class="note-description">찬 겨울 아침 공기 속에 퍼지는 약한 샴푸 향</span>
                      </div>
                      <div class="note">
                        <span class="note-type2">MIDDLE NOTES:</span>
                        <span class="note-value">겨울 자스민</span>
                        <span class="note-description">실내에서 은은하게 나는 꽃 방향제 향</span>
                      </div>
                      <div class="note">
                        <span class="note-type3">BASE NOTES:</span>
                        <span class="note-value">흰 동백꽃</span>
                        <span class="note-description">로션을 바른 후 피부에 남는 포근한 잔향</span>
                      </div>
                    </div>
                  </div>
                </div>
            </section>
          
    <section class="cards">
                <div class="cards__single spring card-bg">
              <div class="cards__front">
                <h1 class="cards__artist" tabindex="0">Spring Perfume</h1>
                <img class="cards__image" src="image/perfume9.png" alt="Bon Iver album" />
              </div>
              <div class="cards__back">
                <h2 class="recipe-title">Recipe</h2>
                <div class="notes">
                  <div class="note">
                    <span class="note-type1"> TOP NOTES:</span>
                    <span class="note-value">수선화</span>
                    <span class="note-description">햇빛에 잘 마른 흰 수건에서 나는 향</span>  
                  </div>
                 
                  <div class="note">
                    <span class="note-type2">MIDDLE NOTES:</span>
                    <span class="note-value">은방울꽃</span>
                    <span class="note-description">하얀 비누향</span>
                  </div>
                  <div class="note">
                    <span class="note-type3">BASE NOTES:</span>
                    <span class="note-value">카네이션</span>
                    <span class="note-description">향긋하고 스파이시한 향</span>
                  </div>
                </div>
              </div>
            </div>
              
                <div class="cards__single summer card-bg">
                  <div class="cards__front">
                    <h1 class="cards__artist" tabindex="0">Summer Perfume</h1>
                    <img class="cards__image" src="image/perfume15.png" alt="Guns N' Roses Album" />
                  </div>
                  <div class="cards__back">
                    <h2 class="recipe-title">Recipe</h2>
                    <div class="notes">
                      <div class="note">
                        <span class="note-type1">TOP NOTES:</span>
                        <span class="note-value">백합</span>
                        <span class="note-description">풍부하고 고급진 향수 향</span>
                      </div>
                      <div class="note">
                        <span class="note-type2">MIDDLE NOTES:</span>
                        <span class="note-value">해바라기</span>
                        <span class="note-description">햇빛 쨍한 날 마당에서 나는 풀 냄새</span>
                      </div>
                      <div class="note">
                        <span class="note-type3">BASE NOTES:</span>
                        <span class="note-value">수국</span>
                        <span class="note-description">물기 머금은 꽃향</span>
                      </div>
                    </div>
                  </div>
                </div>
              
                <div class="cards__single autumn card-bg">
                  <div class="cards__front">
                    <h1 class="cards__artist" tabindex="0">Autumn Perfume</h1>
                    <img class="cards__image" src="image/perfume20.png" alt="Arctic Monkeys album" />
                  </div>
                  <div class="cards__back">
                    <h2 class="recipe-title">Recipe</h2>
                    <div class="notes">
                      <div class="note">
                        <span class="note-type1">TOP NOTES:</span>
                        <span class="note-value">네롤리</span>
                        <span class="note-description">상큼하고 달달한 귤꽃 향</span>
                      </div>
                      <div class="note">
                        <span class="note-type2">MIDDLE NOTES:</span>
                        <span class="note-value">핑크뮬리</span>
                        <span class="note-description">부드러운 섬유유연제 향</span>
                      </div>
                      <div class="note">
                        <span class="note-type3">BASE NOTES:</span>
                        <span class="note-value">메리골드</span>
                        <span class="note-description">생화 줄기 향</span>
                      </div>
                    </div>
                  </div>
                </div>
              
                <div class="cards__single winter card-bg">
                    <div class="cards__front">
                      <h1 class="cards__artist" tabindex="0">Winter Perfume</h1>
                      <img class="cards__image" src="image/perfume31.png" alt="Leon Bridges album" />
                    </div>
                      <div class="cards__back">
                        <h2 class="recipe-title">Recipe</h2>
                        <div class="notes">
                          <div class="note">
                            <span class="note-type1">TOP NOTES:</span>
                            <span class="note-value">시클라멘</span>
                            <span class="note-description">서늘한 겨울 공기 향</span>
                          </div>
                          <div class="note">
                            <span class="note-type2">MIDDLE NOTES:</span>
                            <span class="note-value">겨울 매화</span>
                            <span class="note-description">고요하고 깨끗한 꽃향</span>
                          </div>
                          <div class="note">
                            <span class="note-type3">BASE NOTES:</span>
                            <span class="note-value">아이리스</span>
                            <span class="note-description">화장대의 파우더리하고 우아한 잔향</span>
                          </div>
                        </div>
                      </div>
                    </div>
                </section>

                <div class="btn-group">
                    <button class="btn" onclick="location.href='custom2.html'">직접 커스텀 하기</button>
                    <button class="btn" onclick="location.href='custom1.jsp'">돌아가기</button>
                  </div>
          
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
        const cards = document.querySelectorAll(".cards__single");

function flipCard() {
  this.classList.toggle("flip");
}
cards.forEach((card) => card.addEventListener("click", flipCard));
    </script>
</body>
</html>