<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.the.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="com.the.dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송정보</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="../00css/base.css">
<link rel="stylesheet" href="../00css/common.css">
<link rel="shortcut icon" href="../00img/ico_favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/00BookJSP/00css/historyId.css">
<link rel="stylesheet" href="/00BookJSP/00css/style.css">
</head>
<body>
<%
    String history_id = request.getParameter("history_id");
    //history_id로 state 가져오기
    HistoryDto hdto = HistoryDao.select(history_id);
    int shipState = hdto.getShip_state();

    String imagePath = "";
    String statusMessage = "상품 접수 완료";

    switch (shipState) {
       case 1:
             imagePath = "/00BookJSP/00img/package-box_on.png";
           statusMessage = "상품 접수 완료";
           break;
        case 2:
           imagePath = "/00BookJSP/00img/package_on.png";
            statusMessage = "배송 준비 중";
            break;
        case 3:
           imagePath = "/00BookJSP/00img/fast-delivery_on.png";
            statusMessage = "배송 중";
            break;
        case 4:
           imagePath = "/00BookJSP/00img/delivered_on.png";
            statusMessage = "배송 완료";
            break;
        default:
            imagePath = "1.png";
            statusMessage = "상품 접수 완료";
            break;
    }

%>
<div class="eventHeader">
      <p>
         회원 가입 시<span> 첫구매 100원</span> 이벤트
      </p>
</div>
<header id="header">
      <div class="headerTop">
         <h1 class="logo">
            <a href="/00BookJSP/main.jsp"><img src="/00BookJSP/00img/logo.png" alt="로켓서점"></a>
         </h1>
         <form class="searchForm">
            <input type="text" placeholder="검색어를 입력하세요">
            <button class="submit"></button>
         </form>
         <%@ include file="../07users/header.jsp"%>
      </div><!-- headerTop -->
      <div class="headerBottom">
         <a href="#" class="open_btn"> <span></span> <span></span> <span></span>
            <span></span>
         </a>
         <ul class="menu">
         <%@ include file="../03categories/select.jsp" %>
         </ul>
         <ul class="hbUtil">
            <li><a href="/00BookJSP/04cart/cartList.jsp">
               <img src="/00BookJSP/00img/ico_cart.png">
            </a></li>
            <li><a href="/00BookJSP/mypage.jsp">
               <img src="/00BookJSP/00img/ico_user.png">
            </a></li>
         </ul>
      </div><!-- "headerBottom" -->
      <div class="headerLine"></div>
   </header>
   <main>
      <div class="middle_header">
         <div class="middle_top">
            <ul>
               <li><a href="/00BookJSP//main.jsp"><img src="../00img/home-black.png" id="home"></a></li>
               <li><a href="/00BookJSP/mypage.jsp">마이</a></li>
               <li>쇼핑내역</li>
               <li><a href="/00BookJSP/05orders/ordersList.jsp">주문배송목록</a></li>
               <li>주문정보</li>
               <li>배송정보</li>
            </ul>
         </div>
         <div class="middle">
            <div class="left">
               <div>
                  <div class="face">
                  <img src="/00BookJSP/00img/user.png">
                  <div class="name"><b><%
                           if (loggedInUser != null) {
                           %>
                           <%=loggedInUser.getUser_name()%>
                           <%
                           }
                           %>님</b></div>
                  </div>
               </div>
               <div class="rank"><img src="/00BookJSP/00img/crown.png">VIP</div>
               <div id="menu">
                  <ul>
                     <li id="sub_menu">쇼핑내역
                        <ul>
                           <li><a href="/00BookJSP/05orders/ordersList.jsp">주문/배송목록</a></li>
                           <li>선물함</li>
                           <li>매장 구매 내역</li>
                           <li>영수증 조회/후 적립</li>
                        </ul>
                     </li>
                     <li id="sub_menu">회원정보
                        <ul>
                           <li><a href="/00BookJSP/07users/updateConfirm.jsp">회원정보
                                 수정</a></li>
                           <li>로그인 설정</li>
                           <li>마케팅 수신 설정</li>
                           <li><a href="/00BookJSP/01ship/shiplist.jsp">배송 주소록</a></li>
                        </ul>
                     </li>
                     <li id="sub_menu">라이브러리
                        <ul>
                           <li>메인</li>
                           <li>리스트</li>
                           <li>코멘트</li>
                           <li>문장수집</li>
                           <li><a href="/00BookJSP/08wishlist/mywishlist.jsp">위시리스트</a></li>
                           <li>구독</li>
                           <li>e-라이브러리</li>
                        </ul>
                     </li>
                     <li id="sub_menu">문의내역
                        <ul>
                           <li>1:1 문의</li>
                        </ul>
                     </li>
                  </ul>
               </div>
            </div>
            <div class="right">
               <div id="delivery">배송정보</div>
               <table class="notice">
                  <tr>
                     <td>등기 및 소포 우편물의 배송정보를 조회할 수 있습니다. (배송 문의 가능 시간 : 18시까지)</td>
                  </tr>
                  <tr>
                     <td>
                     본 서비스인 배송조회는 우편물의 배송상태를 고객이 신속히 확인할 수 있도록 제공하는 것이 목적으로 모든 배송정보가 표시되지 않을 수 있습니다.<br>
                     우편물과 관련된 법적 증거 자료가 필요한 경우, <b>로켓법 시행규칙 제25조 제1항 제4호 다목 및 제59조</b>에 따른 <b>배달증명서비스</b>를 이용해 주시기 바랍니다.<br>
                     <b>로켓서점의 배송은 자사가 직접 운영</b>하며, 주문 즉시 상품을 준비하고 배송을 진행하오니 이 점 참고하여 주시기 바랍니다.<br>
                     ※ <b>주문 취소 및 배송지 변경이 어려우므로</b> 신중하게 주문해 주시기 바라며, 자세한 사항은 고객센터로 문의해 주세요.<br>
                     <b>(모니터 뒤에 사람이 있으니, 욕설은 지양해주세요^^)</b>
                     </td>
                  </tr>
               </table>
               <div><img src="/00BookJSP/00img/circle.png" id="circle"><b>배송진행 상황</b></div>
               <hr id="circle_hr">
               <div class="delivery_process">
                  <div>
                      <img src="/00BookJSP/00img/delivery/package-box<%= shipState == 1 ? "_on" : "" %>.png">
                       <p>상품준비중<p>
                  </div>
                  <div>
                       <img src="/00BookJSP/00img/delivery/package<%= shipState == 2 ? "_on" : "" %>.png">
                      <p>배송준비중<p>
                  </div>
                  <div>
                      <img src="/00BookJSP/00img/delivery/fast-delivery<%= shipState == 3 ? "_on" : "" %>.png">
                      <p>배송중</p>
                  </div>
                  <div>
                      <img src="/00BookJSP/00img/delivery/delivered<%= shipState == 4 ? "_on" : "" %>.png">
                      <p>배송완료</p>
                  </div>
               </div>
               <table class="state">
                  <tr>
                     <th>배송상태</th>
                  </tr>
                  <tr>
                     <td><%= statusMessage %></td>
                  </tr>
               </table>
               <div><img src="/00BookJSP/00img/circle.png" id="circle"><b>기본 정보</b></div>
               <hr id="circle_hr">
               <table class="information">
                  <tr>
                     <th>운송장번호</th><th>보내는 분/접수일자</th>
                     <th>받는분</th><th>수령인/배달일자</th><th>배송현황</th>
                  </tr>
                  <tr>
                     <td><%=history_id %></td>
                     <td>주식회사:로켓서점<br><%= history_id.substring(2, 10) %></td>
                     <td><%
                              if (loggedInUser != null) {
                              %>
                              <%=loggedInUser.getUser_name()%>
                              <%
                              }
                              %></td>
                     <td><%
                              if (loggedInUser != null) {
                              %>
                              <%=loggedInUser.getUser_name()%>
                              <%
                              }
                              %><br><%= history_id.substring(2, 10) %></td>
                     <td><%= statusMessage %></td>
                  </tr>
               </table>
            </div>
         </div>
      </div>
   </main>

<footer id="footer">
      <div id="footercontent">
         <a href="/00BookJSP/main.jsp"><img
            src="/00BookJSP/00img/logo.png" alt="Logo"></a>
         <div id="footertext">
            <p>고객센터</p>
            <p style="font-size: 20px;">1577-5141</p>
            <p>평일 09:00 - 18:00 (주말, 공휴일 제외)</p>
            <div id="buttongroup">
               <button>자주 하는 질문</button>
               <button>1:1 문의</button>
            </div>
         </div>
      </div>
      <div id="footerline">
         <div class="ftinner">
            <img src="../00img/ft_logo.png" alt="로켓서점">
            <ul class="footerInfor">
               <li>서울특별시 종로구 우정국로 2025길 1</li>
               <li>대표이사: 박수민</li>
               <li>사업자등록번호 202-504-030111 <span><a>(사업자정보확인 > )</a></span></li>
            </ul>
            <p>&copy; 2025 로켓 서점</p>
         </div>
      </div>
   </footer>
   <div>
      <a href="#" id="topBtn">TOP</a>
   </div>
   <script>
   //헤더 상단 고정
   document.addEventListener("DOMContentLoaded", function() {
      let header = document.getElementById("header");
      window.addEventListener("scroll", function() {
         if (window.scrollY > 35) {
            header.classList.add("scrolled");
            eventBanner.style.display = "none";
         } else {
            header.classList.remove("scrolled");
            eventBanner.style.display = "block";
         }
      });
   });
   
   /* topBtn 버튼 */
   let topBtn = document.getElementById('topBtn');
   topBtn.addEventListener('click', function(e) {
      e.preventDefault(); //a태그의  href기능을 막아줌
      window.scrollTo({
         top : 0,
         behavior : "smooth"
      });
   });
   </script>
</body>
</html>