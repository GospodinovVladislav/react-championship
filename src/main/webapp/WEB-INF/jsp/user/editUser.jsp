<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.error {
	color: red;
	font-weight: bold;
}
</style>
<%@include file="../header.jsp"%>
</head>
<body>

	<form:form action="/championship/app/users/edit"
		class="form-horizontal" method="post" commandName="userBean"
		enctype="multipart/form-data">
		<form:hidden path="id" />
		<br>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="textinput">Email</label>
			<div class="col-md-4">
				<form:input id="e-mail" name="e-mail" path="email" type="text"
					class="e-mail form-control input-md" />
				<form:errors path="email" cssClass="error" />
			</div>
		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="textinput">First
				Name</label>
			<div class="col-md-4">
				<form:input id="first_name" path="firstName" name="first_name"
					type="text" class="first_name form-control input-md" />
				<form:errors path="firstName" cssClass="error" />
			</div>

		</div>

		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="textinput">Last
				Name</label>
			<div class="col-md-4">
				<form:input id="last_name" name="last_name" path="lastName"
					type="text" class=" last_name form-control input-md" />
				<form:errors path="lastName" cssClass="error" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">Current
				Picture</label> <img src="../../../img/${userBean.photoFileName}"
				height="100" id="img" class="input-md" width="100" />
		</div>
		<!-- File Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="filebutton">Change
				Picture</label>
			<div class="col-md-4">
				<input type="file" onchange="readURL(this);" name="picture"
					accept="image/jpeg, image/png">
			</div>
		</div>


		<shiro:hasRole name="admin">
			<div class="form-group">
				<label class="col-md-4 control-label" for="checkboxes">Admin
					Yes/No?</label>
				<div class="col-md-4">
					<label class="checkbox-inline" for="checkboxes-0"> <input
						type="checkbox" name="checkboxes" id="checkboxes-0" value="Admin">
					</label>
				</div>
			</div>
		</shiro:hasRole>

		<div class="form-group">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<input type="submit" name="register-submit" id="register-submit"
						tabindex="4" class="btn btn-primary center-block"
						value="Edit User">
				</div>
			</div>
		</div>

	</form:form>
	<script type="text/javascript">
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#img').attr('src', e.target.result).width(100).height(
							100).show();
				};

				reader.readAsDataURL(input.files[0]);
			}
		}
		
		var isAdmin = ${isAdmin};
		if(isAdmin){
			$('input:checkbox').prop('checked', true);
		}
	</script>

</body>
</html>