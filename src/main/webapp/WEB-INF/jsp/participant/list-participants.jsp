<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>



<html>
<head>
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Championship - Participants list</title>


<%@include file="../header.jsp"%>

<h1 style="color: red" class="text-center">Participants List</h1>

<div class="container">
	<display:table requestURI="participants" id="participant"
		name="participants" class="table">
		<display:column property="id" title="ID" class="hidden id"
			headerClass="hidden" media="html"></display:column>
		<display:column property="email" title="email" class="hidden email"
			headerClass="hidden" media="html"></display:column>
		<display:column>
			<img src="../img/${participant.photoFileName}" height="60"
				width="60" />
		</display:column>
		<display:column title="First name" sortable="true"
			property="firstName" class="firstName" />
		<display:column title="Last name" sortable="true" property="lastName"
			class="lastName" />
		<display:column title="Matches Won" sortable="true"
			property="score.matchesWon" class="matchesWon" />
		<display:column title="Matches Lost" sortable="true"
			property="score.matchesLost" class="matchesLost" />
		<display:column title="Points Made" sortable="true"
			property="score.pointsMade" class="pointsMade" />
		<display:column title="Points Taken" sortable="true"
			property="score.pointsTaken" class="pointsTaken" />
		<display:column title="Score" sortable="true" property="score.score"
			class="score" />
		<shiro:hasRole name="admin">
			<display:column>
			<button type="button" class="editParticipant btn btn-info btn-sm waves-effect waves-light">Edit
						Participant</button>
			</display:column>
			<display:column>
			<c:if test="${!participant.isInGroup}">
			<button type="button" data-id="${participant.id}"
						class="deleteParticipant btn btn-danger btn-sm waves-effect waves-light"
						data-toggle="modal" data-target="#removeParticipant">Remove</button>
			</c:if>
			</display:column>
		</shiro:hasRole>
	</display:table>
	
	<shiro:hasRole name="admin">
	<button type="button"
		class="addParticipant center btn btn-lg btn-success center-block">Add
		Participant</button>
</shiro:hasRole>
</div>



<div class="modal fade" id="removeParticipant" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Remove Participant</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" id="cancel"
						class="btn btn-primary waves-effect waves-light"
						data-dismiss="modal">Close</button>
					<button type="button" id="confirmRemove"
						class="btn btn-danger waves-effect waves-light">Remove</button>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
$('.editParticipant')
.on('click',function() {
	var id = $(this).parent().parent().find('.id').text();
	window.location = "/championship/app/participants/edit/" + id;
});
		$('.addParticipant')
		.on('click',function() {
			window.location = "/championship/app/participants/add";
		});
		$('#removeParticipant').on('hidden.bs.modal', function() {
			$(this).removeData('bs.modal');
		});
		$('#removeParticipant').on('show.bs.modal',function(e) {
			var id = $(e.relatedTarget).data('id');
			$.ajax({
				url : 'participants/getParticipant',
				data : ({id : id}),
				success : function(data) {
					$('#removeParticipant').find('.modal-body')
					.html('<img src=../img/' + data.photoFileName +' height="60" width="60"/> Are you sure you want to remove '
															+ data.firstName
															+ " "
															+ data.lastName
															+ '?');
							}
					});

					$('#confirmRemove').on('click',function() {
										window.location = "/championship/app/participants/"
												+ id + "/delete";
									});
				})
</script>

</head>
</html>