<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee List</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- Web Path:
Relative Path Not Started with '/': Find Resources by Current Resource's Path, Causing Problems Easily
Relative Path Started with '/': Find Resources by Server's Path (http://localhost:3306) Plus Project Name
		http://localhost:3306/crud
 -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- Build Display Page -->
	<div class="container">
		<!-- Title -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- Button -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">Add</button>
				<button class="btn btn-danger">Delete</button>
			</div>
		</div>
		<!-- Display Table Data -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>Action</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
						<th>${emp.empId}</th>
						<th>${emp.empName}</th>
						<th>${emp.gender=="M"?"Male":"Female"}</th>
						<th>${emp.email}</th>
						<th>${emp.department.deptName}</th>
						<th>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								Edit
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								Delete
							</button>
						</th>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- Display Page Info -->
		<div class="row">
			<!-- Page Word Info -->
			<div class="col-md-6">
				Current ${pageInfo.pageNum} in ${pageInfo.pages} Pages (${pageInfo.total} Records)
			</div>
			<!-- Page Strip Info -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				    <li><a href="${APP_PATH}/emps?pn=1">First</a></li>
				    <c:if test="${pageInfo.hasPreviousPage}">
				  		<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
				    	<c:if test="${page_Num == pageInfo.pageNum}">
				    		<li class="active"><a href="#">${page_Num}</a></li>
				    	</c:if>
				    	<c:if test="${page_Num != pageInfo.pageNum}">
				    		<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage}">
				    	<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">Last</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	
</body>
</html>