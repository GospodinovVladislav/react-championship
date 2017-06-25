<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@page import="bg.diplomna.championship.dao.User"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Championship - Users list</title>
<style type="text/css">
#cancel, #confirmDeletion {
	display: inline-block;
	margin-right: 5px;
}
</style>
</head>

<body>


	<%@include file="../header.jsp"%>


	<h1 style="color: blue" class="text-center">Users List</h1>

	<br>
	<div class="container">
		<display:table id="user" requestURI="users" name="users" class="table">
			<display:column property="id" title="ID" class="hidden id"
				headerClass="hidden" media="html"></display:column>
			<display:column>
				<img src="../img/${user.photoFileName}" height="60" width="60" />
			</display:column>
			<display:column title="First name" sortable="true"
				property="firstName" class="firstName" />
			<display:column title="Last name" property="lastName"
				class="lastName" />
			<display:column title="E-mail" property="email" class="email" />
			<shiro:hasRole name="admin">
				<c:choose>
					<c:when test="${user.isParticipant}">
						<display:column>
						</display:column>
					</c:when>
					<c:when test="${!user.isParticipant}">
						<display:column>
							<button type="button"
								class="btn btn-success btn-md addToParticipants waves-effect waves-light"
								data-id="${user.id}" data-toggle="modal"
								data-target="#addToParticipantsModal">Add to
								participants</button>
						</display:column>
					</c:when>
				</c:choose>
				<display:column>
					<button type="button"
						class="btn btn-info btn-md editUser waves-effect waves-light">Edit
						User</button>
				</display:column>
				<display:column>
				<c:if test="${!user.isAdmin}">
					<button type="button" id="deleteUser" data-id="${user.id}"
						class="btn btn-danger btn-md waves-effect waves-light"
						data-toggle="modal" data-target="#deleteUserModal">Delete
						User</button>
				</c:if>
				</display:column>
			</shiro:hasRole>
		</display:table>
	</div>



	<div class="modal fade" id="deleteUserModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Delete User</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" id="cancel"
						class="btn btn-primary waves-effect waves-light"
						data-dismiss="modal">Close</button>
					<button type="button" id="confirmDeletion"
						class="btn btn-danger waves-effect waves-light">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="addToParticipantsModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add to Participants</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" id="cancel"
						class="btn btn-primary waves-effect waves-light"
						data-dismiss="modal">Close</button>
					<button type="button" id="confirmAdd"
						class="btn btn-success waves-effect waves-light">Add</button>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
		$('.editUser').on('click', function() {
			var id = $(this).parent().parent().find('.id').text();
			window.location = "/championship/app/users/" + id + "/openForEdit";
		});

		$('#deleteUserModal').on('hidden.bs.modal', function() {
			$(this).removeData('bs.modal');
		});
		$('#addToParticipantsModal').on('hidden.bs.modal', function() {
			$(this).removeData('bs.modal');
		});

		$('#addToParticipantsModal')
				.on(
						'show.bs.modal',
						function(e) {
							var id = $(e.relatedTarget).data('id');
							$
									.ajax({
										url : 'users/getUser',
										data : ({
											id : id
										}),
										success : function(data) {
											$('#addToParticipantsModal')
													.find('.modal-body')
													.html(
															'<img src=../img/' + data.photoFileName +' height="60" width="60"/> Are you sure you want to add '
																	+ data.firstName
																	+ " "
																	+ data.lastName
																	+ ' to participants list?');

										}
									});

							$('#confirmAdd')
									.on(
											'click',
											function() {
												window.location = "/championship/app/participants/addFromUsers/"
														+ id;
											});
						})

		$('#deleteUserModal')
				.on(
						'show.bs.modal',
						function(e) {
							var id = $(e.relatedTarget).data('id');
							$
									.ajax({
										url : 'users/getUser',
										data : ({
											id : id
										}),
										success : function(data) {
											$('#deleteUserModal')
													.find('.modal-body')
													.html(
															'<img src=../img/' + data.photoFileName +' height="60" width="60"/> Are you sure you want to delete '
																	+ data.firstName
																	+ " "
																	+ data.lastName
																	+ '?');

										}
									});

							$('#confirmDeletion')
									.on(
											'click',
											function() {
												window.location = "/championship/app/users/"
														+ id + "/delete";
											});
						})
	</script>
</body>
</html>