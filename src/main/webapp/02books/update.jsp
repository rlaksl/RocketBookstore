<%@page import="com.the.dao.CategoriesDao"%>
<%@page import="com.the.dto.CategoriesDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.the.dto.BooksDto"%>
<%@page import="com.the.dao.BooksDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 수정 | 관리자</title>
<link rel="stylesheet" href="../00css/base.css">
<link rel="stylesheet" href="../00css/owner.css">
<link rel="shortcut icon" href="../00img/ico_favicon.ico" type="image/x-icon">
<style>
.menu li:nth-child(4) a{
    color: black;
    text-decoration: underline;
}
form{margin: 50px auto; width:500px; margin-left: 800px;}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String bookIdParam = request.getParameter("book_id");
	Long book_id = Long.parseLong(bookIdParam);
	
	//book_id가 null인 경우 처리
	if (bookIdParam == null || bookIdParam.isEmpty()) {
		out.println("book_id가 없습니다.");
	} else {

		// 데이터베이스에서 책 정보를 가져오기
		BooksDao dao = new BooksDao(); // BookDao 객체생성
		CategoriesDao categoriesDao = new CategoriesDao(); // 카테고리 객체 생성
		
		// book_id를 매개변수로 책 정보 가져오기.
		BooksDto dto = dao.getBookById(book_id);

		// dto가 null일 경우 예외 처리
		if (dto == null) {
			out.println("해당 책 정보를 찾을 수 없습니다.");
		} else {
			String title = dto.getTitle();
			String author = dto.getAuthor();
			Long price = dto.getPrice();
			String detail = dto.getDetail();
			Long stock = dto.getStock();
			Long currentCategoryId = dto.getCategory_id(); 
			
 			// 카테고리 정보 가져오기
            ArrayList<CategoriesDto> categories = categoriesDao.selectAll();
            request.setAttribute("categories", categories); 
	%>
	<div id="wrap">
		<h1>
			<a href="ownerPage.jsp">
				<img src="/00BookJSP/00img/adimnLogo.png" alt="로켓서점">
			</a>
		</h1>
		<div class="logout">
			<span><%@ include file="../07users/header1.jsp"%></span>
			<a href="<%=request.getContextPath()%>/07users/logout.jsp">로그아웃</a>
		</div>
		<ul class="menu">
   			<li><a href="<%=request.getContextPath()%>/01ship/shipSelect.jsp">배송지 전체</a></li>
 		   	<li><a href="<%=request.getContextPath()%>/09stock_logs/stockLogsSelect.jsp">재고 관리</a></li>
    		<li><a href="<%=request.getContextPath()%>/07users/member.jsp">회원 관리</a></li>
    		<li><a href="<%=request.getContextPath()%>/02books/adminSelect.jsp">도서 관리</a></li>
    		<li><a href="<%=request.getContextPath()%>/05orders/ordersSelect.jsp">주문 관리</a></li>
		</ul>
		<div class="line"></div>
	
	<form action="updateDB.jsp" method="post">
		<!-- book updateDB로 -->
		책 ID: <%=book_id%><br> 
		<input type="hidden" name = "book_id" value="<%= book_id %>">
		제목: <input type="text" name="title" value="<%= title != null ? title : "" %>"><br> 
        저자: <input type="text" name="author" value="<%= author != null ? author : "" %>"><br> 
        가격: <input type="text" name="price" value="<%= price != null ? price : "" %>"><br> 
			재고: <%=stock %><br>
			카테고리 : 
			<select name="category_id">
            <%
            // 카테고리 목록을 출력하면서 현재 책의 카테고리 ID가 선택된 상태로 표시.
            for (CategoriesDto category : categories) {
                // 현재 책의 카테고리 ID와 일치하는 카테고리명을 기본으로 선택하도록 함
                String selected = (category.getCategory_id().equals(currentCategoryId)) ? "selected" : "";
            %>
                <option value="<%=category.getCategory_id()%>" <%=selected%>>
                    <%=category.getName()%>
                </option>
            <%
            }
            %>
        </select> <br>
        
			설명: <input type="text" name="detail" value="<%= detail != null ? detail : "" %>"><br> 
			<input type="submit" value="전송"> 
	</form>


	<%
		} // dto != null
	}
	%>
	</div>

</body>
</body>
</html>