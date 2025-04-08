<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.the.dao.*"%>
<%@page import="com.the.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../00css/base.css">
<link rel="stylesheet" href="../00css/owner.css">
<link rel="shortcut icon" href="./00img/ico_favicon.ico"
	type="image/x-icon">
<style>
* {
	margin: 0 auto;
}

table {width: 60%;
	border-collapse: collapse;
	margin-top: 50px;
	margin: 50px auto;
        }

th, td {
	border: 1px solid black;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
        .menu li:nth-child(5) a{
    color: black;
    text-decoration: underline;
}
h3{text-align: center; margin:50px auto 20px }
p{text-align: center; margin-bottom: 15px;}
</style>
</head>
<body>
	<%
   String user_id = (String) request.getParameter("user_id");
   String order_id = request.getParameter("order_id");
   
   ArrayList<OrdersReciptDto> dtos = OrdersReciptDao.selectAll2(order_id);
   request.setAttribute("ordersReciptList", dtos);
   for(OrdersReciptDto item:dtos){
      System.out.println(item);
   }
   
   ArrayList<OrdersDto> ordersList = OrdersDao.selectAll();
   if (ordersList != null) {
      for(OrdersDto item:ordersList){
         System.out.println(item);
      }
    } else {
          response.sendRedirect("orderBlank.jsp");
    }
   request.setAttribute("ordersList", ordersList);
   
   String history_id = ordersList.get(0).getHistory_id();
   long ship_id = ordersList.get(0).getShip_id();
   String user_id1 = ordersList.get(0).getUser_id(); //누른 주문시킨 유저
   
   ShipDto shipDto = ShipDao.selectAll(user_id1, ship_id);
   System.out.println(shipDto);
   request.setAttribute("shipDto", shipDto);
   
   //사용자 정보
   UsersDto udto = UsersDao.select(user_id1);
   System.out.println(udto);
   
   String userID = udto.getUser_id();
   request.setAttribute("userID", userID);
   String name = udto.getUser_name();
   request.setAttribute("name", name);
   String email = udto.getEmail();
   request.setAttribute("email", email);
   String phone = udto.getPhone();
   request.setAttribute("phone", phone);
   
   BooksDao booksDao = new BooksDao();
   
   int totalPrice=4000;
   for (OrdersReciptDto item : dtos) {
        BooksDto book = booksDao.selectAll(item.getBook_id());// book_id로 책 정보 가져오기
        if (book != null) {
            totalPrice += book.getPrice() * item.getAmount(); // 가격 * 수량
        }
    }
   
   request.setAttribute("totalPrice", totalPrice);
   

%>
	<div id="wrap">
		<h1>
			<a href="ownerPage.jsp"> <img
				src="/00BookJSP/00img/adimnLogo.png" alt="로켓서점">
			</a>
		</h1>
		<div class="logout">
			<span><%@ include file="../07users/header1.jsp"%></span>
			<a href="<%=request.getContextPath()%>/07users/logout.jsp">로그아웃</a>
		</div>
		<ul class="menu">
			<li><a
				href="<%=request.getContextPath()%>/01ship/shipSelect.jsp">배송지
					전체</a></li>
			<li><a
				href="<%=request.getContextPath()%>/09stock_logs/stockLogsSelect.jsp">재고
					관리</a></li>
			<li><a href="<%=request.getContextPath()%>/07users/member.jsp">회원
					관리</a></li>
			<li><a
				href="<%=request.getContextPath()%>/02books/adminSelect.jsp">도서
					관리</a></li>
			<li><a
				href="<%=request.getContextPath()%>/05orders/ordersSelect.jsp">주문
					관리</a></li>
		</ul>
		<div class="line"></div>

		<h3>주문정보</h3>
		<p>
			회원 ID :
			<%=userID %></p>
		<p>
			회원 이름 :
			<%=name %></p>
		<p>
			회원 이메일 :
			<%=email %></p>
		<p>
			회원 전화번호 :
			<%=phone %></p>
		<table>
			<thead>
				<tr>
					<th colspan="2">주문번호 : <%=order_id %></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th colspan="2"><a
						href="../06history/historyId.jsp?history_id=<%=history_id %>">
							운송장번호 : <%=history_id %></a></th>
				</tr>
				<tr>
					<th colspan="2">배송지</th>
				</tr>
				<tr>
					<td colspan="2">${shipDto.address}</td>
				</tr>
				<tr>
					<th colspan="2">주문상품</th>
				</tr>
				<c:forEach var="recipt" items="${ordersReciptList }">
					<tr>
						<td>${recipt.title }</td>
						<td>${recipt.amount }</td>
					</tr>
				</c:forEach>
				<tr>
					<th colspan="2">총 가격 : ${totalPrice} 원</th>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>