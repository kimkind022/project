<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="classes.MembersDAO" />
<jsp:useBean id="dto" class="dto.MembersBean" />

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>JOIN</title>
</head>

<!-- 주소검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="script/addressFind.js"></script>

<jsp:include page="common.jsp"></jsp:include>

<script type="text/javascript" src="script/join.js"></script>
<link href="styles/join.css" rel="stylesheet" type="text/css">

<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
  <!--헤더-->
  <jsp:include page="header.jsp"></jsp:include>
  <form onsubmit="return joinClick()" method="post" action="joinOk.jsp">
    <div class="wrap1">
      <section id="joinSection">
        <table>
          <tr align="center">
            <td colspan="3">
              <h1>회원가입</h1>
              <br>
            </td>
          </tr>
          <tr align="center">
            <td colspan="3">
              <div class="SNSSignUp">SNS계정으로 간편하게 회원가입</div>
              <div>
                <img src="images/join/navericon.png" width="40px" align="center" style="padding-right: 10px;">
                <img src="images/join/kakaoicon.png" width="40px" align="center" style="padding-right: 10px;">
                <img src="images/join/googleicon.png" width="40px" align="center">
              </div>
            </td>
          </tr>
          <tr align="center">
            <td colspan="3"></td>
          </tr>
          <tr align="center">
            <td colspan="3">
              <hr />
            </td>
          </tr>
          <tr>
            <td>
              <span>이메일</span>
            </td>
            <td>
              <div class="emailDiv">
                <div>
                  <input type="text" name="id" maxlength="20" size="20" class="text" style="width: 135px;">
                </div>
                <div style="padding: 5px;">@</div>
                <div>
                  <div class="directInput">
                    <div>
                      <input type="text" name="emailSelect" maxlength="20" size="20" class="text" style="width: 90px;">
                    </div>
                    <div>
                      <input type="button" name="close" value="x">
                    </div>
                  </div>
                  <div class="emailSelect">
                    <select name="emailSelect" class="text" style="width: 125px; height: 43px; padding: 0px;">
                      <option selected value="0">선택해주세요</option>
                      <option>naver.com</option>
                      <option>hanmail.net</option>
                      <option>gmail.com</option>
                      <option value="">직접 입력</option>
                    </select>
                  </div>

                </div>
              </div>
            </td>
            <td>
              <input type="button" name="emailSearch" value="중복확인" class="button">
            </td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <span>비밀번호</span>
            </td>
            <td>
              <input type="password" name="pw" maxlength="16" size="40" class="text">
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <span>비밀번호 확인</span>
            </td>
            <td>
              <input type="password" name="pwRe" maxlength="16" size="40" class="text" readonly="readonly">
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <span>이름</span>
            </td>
            <td>
              <input type="text" name="name" maxlength="10" size="40" class="text">
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <span>닉네임</span>
            </td>
            <td>
              <input type="text" name="nickname" maxlength="6" size="40" placeholder="6자 이하로 입력" class="text">
            </td>
            <td>
              <input type="button" name="nickSearch" class="button" value="중복확인">
            </td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <span>생년월일</span>
            </td>
            <td>
              <div class="yearmonthdate">
                <div class="year">
                  <input type="number" class="text" name="year" placeholder="년" style="width: 58px;" >
                </div>
                <div class="month">
                  <select name="month" class="text" style="width: 90px; height: 43px;" disabled="disabled">
                    <option value="0">월</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>
                    <option>9</option>
                    <option>10</option>
                    <option>11</option>
                    <option>12</option>
                  </select>
                </div>
                <div class="day">
                  <input type="number" class="text" name="day" placeholder="일" readonly="readonly" style="width: 60px;">
                </div>
              </div>
            </td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>

          <tr>
            <td>
              <span>휴대폰</span>
            </td>
            <td>
              <input type="text" name="tel" maxlength="11" size="40" placeholder="'-' 제외 숫자만 입력" class="text">
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr>
            <td class="address2">
              <span>주소</span>
            </td>
            <td>
              <div class="address1">
                <input type="text" name="address" class="text" placeholder="주소" readonly>
              </div>
            </td>
            <td class="address2">
              <input type="button" name="addressSearch" value="주소검색" class="button" onclick="execDaumPostcode()">
            </td>
          </tr>
          <tr>
            <td class="address2">
            <td>
              <div class="address1">
                <input type="text" name="addressInfo" class="text" placeholder="상세 주소(동,호수 등)" readonly="readonly">
              </div>
            </td>
            <td class="address2"></td>
          </tr>
          <tr class="inputError">
            <td></td>
            <td>
              <div class="errorTxt"></div>
            </td>
            <td></td>
          </tr>
          <tr align="center">
            <td colspan="3">
              <hr />
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2" class="fWeight">
              <input type="checkbox" name="agreeAll" value="동의" class="checkb" onclick="checkAll(this)">
              전체 동의<br> <br>
              <input type="checkbox" name="agree1" value="동의" class="checkb" onclick="checkAll(this)">
              개인정보 수집 및 이용안내 <font class="cR">*</font><br>
              <input type="checkbox" name="agree2" value="동의" class="checkb" onclick="checkAll(this)">
              마케팅 수신 전체 동의<br>
              <input type="checkbox" name="agree3" value="email" class="checkb" onclick="checkAll(this)">
              <font style="color: gray">이메일</font><br>
              <input type="checkbox" name="agree4" value="SNS" class="checkb" onclick="checkAll(this)">
              <font style="color: gray">SNS</font><br>
              <input type="checkbox" name="agree5" value="app" class="checkb" onclick="checkAll(this)">
              <font style="color: gray">앱 PUSH 알림</font><br> <br> <font size="2"><b>쇼핑몰에서 제공하는 신상품
                  소식/ 할인쿠폰을 무상으로 보내드립니다!<br> 단, 상품 구매 정보는 수신동의 여부 관계없이 발송됩니다.<br> 제공 동의를 하지 않으셔도 서비스 이용에는 문제가
                  없습니다.
              </b></font>
            </td>
          </tr>
          <tr align="center">
            <td colspan="3">
              <br>
              <input type="submit" name="joinBtn" class="bigbtn" value="동의하고 가입완료">
            </td>
          </tr>
        </table>
      </section>
    </div>
  </form>
  <!--풋터-->
  <jsp:include page="footer.jsp"></jsp:include>
</body>

</html>