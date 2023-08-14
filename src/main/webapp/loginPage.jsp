<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.tech.blog.entities.Message" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
.banner-background {
clip-path: polygon(50% 0%, 100% 0, 100% 43%, 100% 95%, 58% 100%, 30% 95%, 0 100%, 0% 43%, 0 0);
}
</style>
</head>
<body>
<%@ include file="normal_navbar.jsp" %>
<main class="d-flex justify-content-center primary-background banner-background p-5" >
<div class="container">
	<div class="row">
		<div class="col-md-4 offset-md-4">
			<div class="card">
				<div class="card-header text-center ">
					<span  class="fa fa-user-plus fa-2x"></span>
					<p>Login</p>
				</div>
				<%
					Message m = (Message)session.getAttribute("msg");
					if(m!=null){
				%>
					<div class="alert <%= m.getCssClass() %> text-center" role="alert">
  						<%= m.getContent() %>
					</div>
				<% 
					session.removeAttribute("msg");
					}
				%>
				<div class="card-body">
					<form action="LoginServlet" method="post">
						<div class="mb-3">
					    	<label for="exampleInputEmail1" class="form-label">Email address</label>
					    	<input name="enteredEmail" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
					    	<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
						</div>
					  <div class="mb-3">
					    <label for="exampleInputPassword1" class="form-label">Password</label>
					    <input name="enteredPassword" required type="password" class="form-control" id="exampleInputPassword1">
					  </div>
					 <div class="container text-center">
					  	<button  type="submit" class="btn btn-primary">Submit</button>
					  </div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
</main>
<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="js/myjs.js"></script>
</body>
</html>