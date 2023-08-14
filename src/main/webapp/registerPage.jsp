<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp</title>
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
<main class="primary-background ">
<div class=""conatainer">
	<div class="col-md-4 offset-md-4 ">
		<div class="card">
			<div class="card-header text-center">
				<span class="fa fa-3x fa-user-circle"></span><br>
				Register here
			</div>
			<div class="card-body">
					<form id="reg-form" action="register" method="post" >
						<div class="mb-3">
					    	<label for="userName" class="form-label">User Name</label>
					    	<input name="userName" type="text" class="form-control" id="userName" placeholder="Username">
						</div>
						<div class="mb-3">
					    	<label for="userEmail" class="form-label">Email address</label>
					    	<input name="userEmail" type="email" class="form-control" id="userEmail" aria-describedby="emailHelp" placeholder="Email">
					    	<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
						</div>
					  <div class="mb-3">
					    <label for="pass" class="form-label">Password</label>
					    <input name="pass" type="password" class="form-control" id="pass" placeholder="password">
					  </div>
					  <div class="mb-3">
					    <label for="gender" class="form-label">Select Gender</label>
					    <input type="radio"  name="gender" value="male"> Male
					    <input type="radio" name="gender" value="female"> Female
					  </div>
					  <div class="form-group">
					  	<textarea name="about" class="form-control" rows="4" cols="30" placeholder="something about yourself"></textarea>
					  </div>
					  <div class="mb-3 form-check">
					    <input name="check" type="checkbox" class="form-check-input" id="check">
					    <label class="form-check-label" for="check">agree terms and condition</label>
					  </div>
					  <div class="container text-center" id="loader" style = "display: none;">
					  		<span class="fa fa-refresh fa-spin fa-4x"></span>
					  		<h4>Please Wait..</h4>
					  </div>
					  <button id="submit-button" type="submit" class="btn btn-primary">Submit</button>
					</form>
				
			</div>
		</div>
	</div>
</div>
</main>
<!-- JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="js/myjs.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("loaded")
		$('#reg-form').on('submit' , function(event) {
			event.preventDefault();
			let form = new FormData(this);
			$('#submit-button').hide();
			$('#loader').show();
			$.ajax({
				url: "register",
				type: "POST",
				data: form,
				success: function(data, textStatus , jqXHR){
					console.log(data);
					$('#submit-button').show();
					$('#loader').hide();
					if(data.trim()=== 'done'){
						swal("registered successfully .. we redirecting to login page")
						.then((value) => {
						  window.location="loginPage.jsp"
						});
					}
					else {
						swal(data);
					}
					
				},
				error : function(jqXHR , textStatus , errorThrown){
					$('#submit-button').show();
					$('#loader').hide();
					console.log(jqXHR);
					swal("Somethin went wrong.. try Again")
				},
				processData : false,
				contentType : false

			});
		})
	})
</script>
</body>
</html>