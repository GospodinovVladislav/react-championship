<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<%@include file="../header.jsp"%>
<style>
@CHARSET "ISO-8859-1";

.error {
	color: red;
	font-weight: bold;
}

body {
	padding-top: 90px;
}

.panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.2);
	box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.2);
}

.panel-login>.panel-heading {
	color: #00415d;
	background-color: #fff;
	border-color: #fff;
	text-align: center;
}

.panel-login>.panel-heading a {
	text-decoration: none;
	color: #666;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}

.panel-login>.panel-heading a.active {
	color: #029f5b;
	font-size: 18px;
}

.panel-login>.panel-heading hr {
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, 0),
		rgba(0, 0, 0, 0.15), rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left, rgba(0, 0, 0, 0),
		rgba(0, 0, 0, 0.15), rgba(0, 0, 0, 0));
	background-image: -ms-linear-gradient(left, rgba(0, 0, 0, 0),
		rgba(0, 0, 0, 0.15), rgba(0, 0, 0, 0));
	background-image: -o-linear-gradient(left, rgba(0, 0, 0, 0),
		rgba(0, 0, 0, 0.15), rgba(0, 0, 0, 0));
}

.panel-login input[type="text"], .panel-login input[type="email"],
	.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}

.panel-login input:hover, .panel-login input:focus {
	outline: none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}

.btn-login {
	background-color: #59B2E0;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #59B2E6;
}

.btn-login:hover, .btn-login:focus {
	color: #fff;
	background-color: #53A3CD;
	border-color: #53A3CD;
}

.forgot-password {
	text-decoration: underline;
	color: #888;
}

.forgot-password:hover, .forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

.btn-register {
	background-color: #1CB94E;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #1CB94A;
}

.btn-register:hover, .btn-register:focus {
	color: #fff;
	background-color: #1CA347;
	border-color: #1CA347;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<a href="#" class="active" id="register-form-link">Register</a>
						</div>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form:form id="register-form"
									action="/championship/app/users/add" method="post"
									commandName="userBean" role="form"
									enctype="multipart/form-data">
									<div class="form-group">
										<form:input type="email" name="email" path="email" id="email"
											tabindex="1" class="e-mail form-control"
											placeholder="Email Address" value="" />
										<form:errors path="email" cssClass="error" />
									</div>
									<div class="form-group">
										<form:input type="password" name="password" path="password"
											id="password" tabindex="1" class="password form-control"
											placeholder="Password" />
										<form:errors path="password" cssClass="error" />
									</div>
									<div class="form-group">
										<form:input type="text" path="firstName" name="first_name"
											onkeyup="isNameOk()" id="first_name" tabindex="1"
											class="first_name form-control" placeholder="First Name"
											value="" />
										<form:errors path="firstName" cssClass="error" />
									</div>
									<div class="form-group">
										<form:input type="text" path="lastName" name="last_name"
											onkeyup="isLastNameOk()" id="last_name" tabindex="1"
											class="last_name form-control" placeholder="Last Name"
											value="" />
										<form:errors path="lastName" cssClass="error" />
									</div>
									<div class="form-group">
										Upload Picture: <input type="file" onchange="readURL(this);"
											name="picture" accept="image/jpeg, image/png"> <img
											id="img" style="display: none" align="right" src="#" /> <br>
										<br>
									</div>

									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit"
													id="register-submit" tabindex="4"
													class="form-control btn btn-register" value="Register Now">
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();

	        reader.onload = function (e) {
	            $('#img')
	                .attr('src', e.target.result)
	                .width(100)
	                .height(100)
	                .show();
	        };

	        reader.readAsDataURL(input.files[0]);
	    }
	}
	</script>
</body>
</html>

