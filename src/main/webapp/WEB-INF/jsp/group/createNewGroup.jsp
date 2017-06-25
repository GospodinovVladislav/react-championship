<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/bootstrap-select.css">
<script src="/js/bootstrap-select.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Group</title>
<%@include file="../header.jsp"%>
</head>
<body>

<div id="createGroup" class="col-md-3">

<form class="form-horizontal">
		<br>
		
		<!-- Text input-->
		<div class="form-group">
		<label class="col-md-offset-2" for="textinput" style="font-size:16px">Enter name of the group</label>
			<div class="col-md-offset-1 col-md-8">
				<input id="groupName" type="text"
					class="groupName form-control input-md"  />
			</div>
		</div>
		
		<label class="col-md-offset-1" style="font-size:14px">Select number of participants</label>
		<select id="numberParticipants" class="selectpicker col-md-offset-4">
  			<option value="two">2</option>
  			<option value="three">3</option>
  			<option value="four">4</option>
  			<option value="five">5</option>
  			<option value="six">6</option>
		</select>
		
		<br><br>
		<div class="form-group">
			<div class="row">
				<div class="col-sm-5 col-sm-offset-4">
					<button id="createGroupButton"
						tabindex="4" class="btn btn-success center-block"
						>Create</button>
				</div>
			</div>
		</div>
</form>
</div>


<div id="chooseParticipants"  class="col-md-6">

	</div>
</body>
<script type="text/javascript">
$('#createGroupButton').on("click",function(){
	var groupName = $('#groupName').val();
	var numberParticipants = $('#numberParticipants').val();
	console.log(groupName)
	console.log(numberParticipants);
	$.get("createGroup/" + groupName+"/" + numberParticipants).success(function (html) {
		$("#chooseParticipants").html(html);
	}).error(function(html){
		$("#chooseParticipants").html("error");
	});
})

</script>
</html>