<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.util.*"%>
<%@page import="com.tech.blog.entities.Post"%>
<% 
PostDao d = new PostDao(ConnectionProvider.getConnection());
List<Post> list=d.getPostLimit();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechBlog</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 43%, 100% 95%, 58% 100%, 30% 95%, 0 100%,
		0% 43%, 0 0);
}
</style>

</head>
<body>

	<%@ include file="normal_navbar.jsp"%>

	<div
		class="container-fluid p-4 primary-background text-white banner-background">
		<div class="container ">
			<div class="jumbotron">
				<h3 class="display-3">Welcome to TechBlog</h3>
				<h3>Welcome to technical blog, word of technology</h3>
				<p> Techblog  serves the purpose of providing a
					platform for sharing information, insights, news, and updates
					related to technology and its various facets. Its primary goal is
					to educate, inform, and engage a tech-savvy audience, as well as
					individuals who are interested in staying updated on the latest
					technological advancements and trends. The website typically covers
					a wide range of topics within the realm of technology,</p>
					
				<a href="loginPage.jsp" class="btn btn-outline-light"><span
					class="	fa fa-user-circle-o"></span> Login </a>
					<a class="btn btn-outline-light" aria-current="page" href="registerPage.jsp"><span class="fa fa-user-plus"></span> SignUp </a>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row mt-2">
		<% for(Post p:list){ %>
			<div class="col-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title"><%=p.getpTitle() %></h5>
						<p class="card-text"><%=p.getpContent() %></p>
						<a href="profile.jsp" class="btn primary-background">Go somewhere</a>
					</div>
				</div>
			</div>
			<%} %>
		</div>
	</div>

	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
	<script src="js/myjs.js"></script>
</body>
</html>