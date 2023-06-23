<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index</title>
</head>

<jsp:include page="common.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="slick/slick.css" />
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
<script type="text/javascript" src="slick/slick.min.js"></script>

<link href="styles/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script/index.js"></script>

<body>
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <form>

    <!-- 이미지 슬라이더 ===============  -->
    <div id="boxWrapper">
      <div class='fade'>
        <div>
          <img src="images/index/slider1.png">
        </div>
        <div>
          <img src="images/index/slider2.png">
        </div>
        <div>
          <img src="images/index/slider3.png">
        </div>
      </div>
    </div>


    <!-- 멘트 + 회원수 ===============  -->
    <div id="mentBG">
      <section id="section">
        <div id="memberamount">
          <ul>
            <li>
              <div>100</div>
              <div>만</div>
              <div>+</div>
              <p>회원수</p>
            </li>
            <li>
              <div>500</div>
              <div>만</div>
              <div>+</div>
              <p>함께 나눈 스토리</p>
            </li>
            <li>
              <div>80</div>
              <div>억</div>
              <div>+</div>
              <p>누적 펀딩 금액</p>
            </li>
            <li>
              <div>10</div>
              <div>만</div>
              <div>+</div>
              <p>오늘 접속자 수</p>
            </li>
          </ul>
        </div>
        <div id="ment">
          <div class="p1">'오늘의 마켓'과 함께 채워갈 즐거운 이야기들,</div>
          <div class="p2">건강한 식생활과 함께 변화하는 일상들.</div>
        </div>
      </section>
    </div>


    <!-- 가운데 카테고리 ===============  -->
    <div id="midNavBG">
      <div id="midNav">
        <span>
          <p>오늘의 마켓</p>
          <p>그 이상의 가치</p>
        </span>
        <span>
          <ul>
            <div class="midNavHr"></div>
            <li class="midNavLi">
              <p class="midNavP">집으로 찾아오는 신선함</p>
              <a href="storeMain.jsp" class="midNavLink">
                스토어
                <img src="images/common/next.png" width="20px">
              </a>
            </li>
            <div class="midNavHr"></div>
            <li class="midNavLi">
              <p class="midNavP">오늘의 싱싱한 이야기</p>
              <a href="communityMain.jsp" class="midNavLink">
                커뮤니티
                <img src="images/common/next.png" width="20px">
              </a>
            </li>
            <div class="midNavHr"></div>
            <li class="midNavLi">
              <p class="midNavP">함께 응원하는 우리 농산물</p>
              <a href="fundingMain.fd" class="midNavLink">
                펀딩
                <img src="images/common/next.png" width="20px">
              </a>
            </li>
          </ul>
        </span>
      </div>
    </div>


    <!-- 이미지3장 ===============  -->

    <section id="section2">
      <a href="storeMain.jsp"></a>
      <div>
        <div class="overlap1">
          <img src="images/index/store.png">
        </div>
        <div class="overlap2">
          <div>스토어</div>
          <div>
            당신의 집으로 찾아오는<br>건강한 먹거리
          </div>
        </div>
        <div class="overlap3">
          <img src="images/index/storeFade.png">
        </div>
        <div class="overlap4">
          <div>우리 농산물, 우리 먹거리</div>
          <div>
            오켓이 꼼꼼히 검수한 제철 채소와 과일, <br />같은 품질에서 최선의 가격을 제공합니다. <br /> <br />여러분의 식탁을 오늘의 마켓과 함께 건강하게 채워보세요!
          </div>
        </div>
      </div>
      <div>
        <div class="overlap1">
          <img src="images/index/community.png">
        </div>
        <div class="overlap2">
          <div>커뮤니티</div>
          <div>
            함께 나누고 있는<br>즐거운 이야기를 확인하세요
          </div>
        </div>
        <div class="overlap3">
          <img src="images/index/communityFade.png">
        </div>

        <div class="overlap4">
          <div>
            이웃과 함께 <br />나누는 이야기
          </div>
          <div>
            내 주변 이웃들은 어떤 요리를 먹을까? <br> 고수의 노하우는 무엇이 있을까? <br> <br> 나와 내 가족이 먹고 나눈 이야기들, <br> 공유하고
            공감하며 더욱 풍성해질 이야기들. <br> 함께 만들어가요.
          </div>
        </div>
      </div>
      <div>
        <div class="overlap1">
          <img src="images/index/funding.png">
        </div>
        <div class="overlap2">
          <div>펀딩</div>
          <div>
            농부의 진심어린<br>마음을 전해드릴게요.
          </div>
        </div>
        <div class="overlap3">
          <img src="images/index/fundingFade.png">
        </div>

        <div class="overlap4">
          <div class="midTitle_fade">
            함께 모여<br>싹트는 마음
          </div>
          <div class="midTxt2">
            농부의 바른 고집을 지키는 든든한 지지자가 되어주세요. <br /> 예쁘지 않아도 맛있는 열매를 맺어준 자연의 마음, 오켓 가족들에게 보내드릴게요. <br /> <br /> 못생겨도
            괜찮아. 여전히 맛있으니까!
          </div>
        </div>
      </div>
    </section>
    <div id="section3BG">
      <section id="section3">
        <div class="pdtContainer">
          <div class="titleDiv">
            <div class="containerTitle">베스트 상품</div>
          </div>
          <div class="multiple-items1">
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storePotato.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[한국농업] 서산 금왕 감자 (900g)</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">5%</font> 4,940 원
                    </b> <br>
                    <span class="pdtnonsale">5,200 원</span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storePeach.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[하늘작] 백도 복숭아 1.8kg(5~8입)</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">5%</font> 18,000 원
                    </b> <br>
                    <span class="pdtnonsale">18,900 원</span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storeCongnamul.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[김구원선생] 국내산 무농약 콩나물 300g</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">5%</font> 1,220 원
                    </b> <br>
                    <span class="pdtnonsale">1280 원</span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storeBrocolli.png">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[콜리] 조각 브로콜리 250g</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">11%</font> 3,790 원
                    </b> <br>
                    <span class="pdtnonsale">4,290 원</span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storeRice.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[방아깨비] 밥맛이 살아나는 쌀 2종</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">10%</font> 35,820 원
                    </b> <br>
                    <span class="pdtnonsale">39,800 원</span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="pdtContents">
              <div class="pdtImg">
                <img src="images/index/storeSalad.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>[피그인더가든] 데일리믹스 베이직샐러드</h3>
                  </li>
                  <li>
                    <b> <font color="F05D23">5%</font> 1,890 원
                    </b> <br>
                    <span class="pdtnonsale">1,980 원</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="titleDiv">
            <div class="containerTitle">지금 뜨는 포스팅</div>
          </div>
          <div class="multiple-items2">
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community1.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>도리도리~ 감자샐러드~</h3>
                  </li>
                  <li>감자도리</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1521</li>
                  <li class="leftlist">스크랩 120</li>
                </ul>
              </div>
            </div>
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community2.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>이런 요리 어때요? 연두부 샐러드</h3>
                  </li>
                  <li>비건맨</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1874</li>
                  <li class="leftlist">스크랩 135</li>
                </ul>
              </div>
            </div>
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community3.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>'장인'의 열무김치 레시피 무료공개</h3>
                  </li>
                  <li>무파마</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1875</li>
                  <li class="leftlist">스크랩 187</li>
                </ul>
              </div>
            </div>
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community4.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>건강채움♥ 오곡밥 황금비율 알려드릴게요</h3>
                  </li>
                  <li>코코볼</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1345</li>
                  <li class="leftlist">스크랩 661</li>
                </ul>
              </div>
            </div>
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community5.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>집들이 상차림 추천! 춘권 만들기</h3>
                  </li>
                  <li>개구리반찬</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1945</li>
                  <li class="leftlist">스크랩 123</li>
                </ul>
              </div>
            </div>
            <div class="contents">
              <div class="postImg">
                <img src="images/community/community6.jpg">
              </div>
              <div class="postTxt">
                <ul>
                  <li>
                    <h3>잭과 콩나물무침</h3>
                  </li>
                  <li>잭</li>
                </ul>
                <ul>
                  <li class="leftlist">조회수 1755</li>
                  <li class="leftlist">스크랩 146</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="container">
            <div class="titleDiv">
              <div class="containerTitle">마감임박 펀딩</div>
            </div>
            <div class="multiple-items3">
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding1.jpg">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>유기농 표고버섯 국내산 GAP 생표고 파지 못난이 특품</h3>
                    </li>
                    <li>표고가 한그루</li>
                    <li>
                      <progress class="progress" value="85" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">85%</span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding2.png">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>강원도 핵감자! 핵세일! 10키로에 5천원 실화?!</h3>
                    </li>
                    <li>강원도청</li>
                    <li>
                      <progress class="progress" value="98" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">98%</span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding3.jpg">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>친환경 못난이 농산물 꾸러미 채소 박스</h3>
                    </li>
                    <li>언밸러스 마켓</li>
                    <li>
                      <progress class="progress" value="77" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">77%</span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding4.jpg">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>화훼농가돕기! 전남 강진 고백장미 1단(10송이)</h3>
                    </li>
                    <li>강진 청자골</li>
                    <li>
                      <progress class="progress" value="85" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">85%</span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding5.png">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>구해줘! 제주 초당옥수수</h3>
                    </li>
                    <li>마담주</li>
                    <li>
                      <progress class="progress" value="96" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">96%</span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="contents">
                <div class="postImg">
                  <img src="images/funding/funding6.jpg">
                </div>
                <div class="postTxt">
                  <ul>
                    <li>
                      <h3>일본으로 수출되는 고품질! 강원도 아스파라거스 1lkg</h3>
                    </li>
                    <li>강원도청</li>
                    <li>
                      <progress class="progress" value="92" min="0" max="100"></progress>
                    </li>
                    <li>
                      <span class="progressValue">%</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </form>

  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

</html>