
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="errorPage.jsp"%>
<%@ page import="com.tech.blog.entities.Message"%>
<%@ page import="com.tech.blog.dao.PostDao"%>
<%@ page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("loginPage.jsp");
}
%>
<%
PostDao p = new PostDao(ConnectionProvider.getConnection());
ArrayList<Category> list = p.getAllCategories();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
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
body{
	background:url(img/bg2.jpg);
	backgroung-size:cover;
	background-attachment:fixed;
}
</style>
</head>
<body>

	<!-- NavBar start -->
	<nav
		class="navbar navbar-expand-lg bg-body-tertiary primary-background">
		<div class="container-fluid ">
			<a class="navbar-brand text-white" href="index.jsp"><span
				class="fa fa-asterisk "></span> TechBlog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active text-white"
						aria-current="page" href="#"><span class="fa fa-bell-o"></span>
							Learning</a></li>
				
					<li class="nav-item"><a class="nav-link active text-white"
						aria-current="page" href="#!" data-bs-toggle="modal"
						data-bs-target="#do-post-modal"><span class="fa fa-asterisk"></span>
							Do Post</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item"><a class="nav-link active text-white"
						aria-current="page" href="#!" data-bs-toggle="modal"
						data-bs-target="#profile-modal"><span
							class="fa fa-user-circle"></span> <%=user.getName()%></a></li>
					<li class="nav-item"><a class="nav-link active text-white"
						aria-current="page" href="LogoutServlet"><span
							class="fa fa-user-plus"></span> Logout </a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- End of NavBar -->
	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%> text-center" role="alert">
		<%=m.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<!-- post -->
	<main>
		<div class="container">
			<div class="row mt-3">
				<div class="col-md-4">
					<div class="list-group">
						<a href="#" onClick="getPosts(<%=0%>,this)" class="c-link list-group-item list-group-item-action active"
							aria-current="true"> All Post</a>
						<%
						for (Category c : list) {
						%>
						<a href="#" onClick="getPosts(<%=c.getCid() %>,this)" class="c-link list-group-item list-group-item-action"><%=c.getName()%></a>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-8" >
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid" id="post-container">
					
					</div>
				</div>
			</div>
		</div>
	</main>


	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background">
					<h1 class="modal-title fs-5" id="exampleModalLabel">TechBlog</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body container text-center">
					<img src="pics/<%=user.getProfile()%>" class="img-fluid"
						style="max-width: 90px; border-radius: 30%;">
					<h1 class="modal-title fs-5" id="exampleModalLabel"><%=user.getName()%></h1>

					<!-- Details -->
					<div id="profile-details">
						<table class="table">
							<tbody>
								<tr>
									<th scope="row">Id :</th>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<th scope="row">Email :</th>
									<td><%=user.getEmail()%></td>
								</tr>
								<tr>
									<th scope="row">Gender :</th>
									<td><%=user.getGender()%></td>
								</tr>
								<tr>
									<th scope="row">Status :</th>
									<td><%=user.getAbout()%></td>
								</tr>
								<tr>
									<th scope="row">Registered on :</th>
									<td><%=user.getDateTime().toLocalDateTime()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="text-center" id="profile-edit" style="display: none;">
						<h3>Please edit carefully</h3>
						<form action="EditServlet" method="post"
							enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td>Id :</td>
									<td><%=user.getId()%></td>
								</tr>
								<tr>
									<td>Email :</td>
									<td><input type="email" class="form-control"
										name="userEmail" value="<%=user.getEmail()%>"></td>
								</tr>
								<tr>
									<td>Name :</td>
									<td><input type="text" class="form-control"
										name="userName" value="<%=user.getName()%>"></td>
								</tr>
								<tr>
									<td>Password :</td>
									<td><input type="password" class="form-control"
										name="userPassword" value="<%=user.getPassword()%>"></td>
								</tr>
								<tr>
									<td>Gender :</td>
									<td><input type="radio" name="userGender" value="male">
										Male <input type="radio" name="userGender" value="female">
										Female</td>
								</tr>
								<tr>
									<td>About :</td>
									<td><textarea class="form-control" rows="3"
											name="userAbout"><%=user.getAbout()%></textarea></td>
								</tr>
								<tr>
									<td>New Profile :</td>
									<td><input type="file" name="userImage"
										class="form-control"></td>
								</tr>
							</table>
							<div class="container">
								<button type="submit" class="btn btn-outline-primary">Save</button>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- End of Edit modal -->



	<!-- Post Modal -->
	<div class="modal fade" id="do-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Provide
						Post Details</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post">
						<div class="form-group">
							<select class="form-control " name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group mt-2">
							<input name="pTitle" type="text" placeHolder="Enter Post Title"
								class="form-control">
						</div>
						<div class="form-group mt-2">
							<textarea name="pContent" class="form-control"
								style="height: 150px" placeHolder="Enter Your Content"></textarea>
						</div>
						<div class="form-group mt-2">
							<textarea name="pCode" class="form-control" style="height: 150px"
								placeHolder="Enter Your Program (If any)"></textarea>
						</div>
						<div class="form-group mt-2">
							<label>Select Your Pic : </label> <input name="pic" type="file">
						</div>
						<div class="container text-center mt-2">
							<button type="submit" class="btn btn-outline-primary">Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- javaScript -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
	<script src="js/myjs.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

	<!-- AJAX for toggle between edit and back button -->
	<script>
		$(document).ready(function() {
			let editStatus = false;
			$('#edit-profile-button').click(function() {
				if (editStatus === false) {
					$('#profile-details').hide();
					$('#profile-edit').show();
					editStatus = true;
					$(this).text("Back");
				} else {
					$('#profile-details').show();
					$('#profile-edit').hide();
					editStatus = false;
					$(this).text("Edit");
				}
			})
		})
	</script>
	<!-- AJAX used for add post  -->
	<script>
		$(document)
				.ready(
						function(e) {
							//
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												//this code gets called when form is submitted....
												event.preventDefault();
												console
														.log("you have clicked on submit..")
												let form = new FormData(this);

												//now requesting to server
												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																//success ..
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"saved successfully",
																			"success");
																} else {
																	swal(
																			"Error!!",
																			"Something went wrong try again...",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																//error..
																swal(
																		"Error!!",
																		"Something went wrong try again...",
																		"error");
															},
															processData : false,
															contentType : false
														})
											})
						})
	</script>

	<!-- loading the post using AJAX -->
	<script>

            function getPosts(catId, temp) {
                $("#loader").show();
                $("#post-container").hide()

                $(".c-link").removeClass('active')


                $.ajax({
                    url: "loadPosts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post-container").show();
                        $('#post-container').html(data)
                        $(temp).addClass('active')

                    }
                })

            }

            $(document).ready(function (e) {

                let allPostRef = $('.c-link')[0]
                getPosts(0, allPostRef)


            })
        </script>
</body>
</html>