<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ page import="bg.diplomna.championship.dao.Group"%>
<%@ page import="bg.diplomna.championship.dao.Participant"%>
<%@ page import="bg.diplomna.championship.dao.Match"%>
<%@ page import="java.util.List"%>


<html>
<head>

<style type="text/css">
body {
  margin: 0;
  font-family: 'Roboto';
  font-size: 14px;
  background: #455A64;
}

h3 {
  color: #fff;
  font-size: 24px;
  text-align: center;
  margin-top: 30px;
  padding-bottom: 30px;
  border-bottom: 1px solid #eee;
  margin-bottom: 30px;
  font-weight: 300;
}

.container {
  max-width: 970px;
}

div[class*='col-'] {
  padding: 0 30px;
}

.wrap {
  box-shadow: 0px 2px 2px 0px rgba(0, 0, 0, 0.14), 0px 3px 1px -2px rgba(0, 0, 0, 0.2), 0px 1px 5px 0px rgba(0, 0, 0, 0.12);
  border-radius: 4px;
}

a:focus,
a:hover,
a:active {
  outline: 0;
  text-decoration: none;
}

.panel {
  border-width: 0 0 1px 0;
  border-style: solid;
  border-color: #fff;
  background: none;
  box-shadow: none;
}

.panel:last-child {
  border-bottom: none;
}

.panel-group > .panel:first-child .panel-heading {
  border-radius: 4px 4px 0 0;
}

.panel-group .panel {
  border-radius: 0;
}

.panel-group .panel + .panel {
  margin-top: 0;
}

.panel-heading {
  background-color: #009688;
  border-radius: 0;
  border: none;
  color: #fff;
  padding: 0;
}

.panel-title a {
  display: block;
  color: #fff;
  padding: 15px;
  position: relative;
  font-size: 16px;
  font-weight: 400;
}

.panel-body {
  background: #fff;
}

.panel:last-child .panel-body {
  border-radius: 0 0 4px 4px;
}

.panel:last-child .panel-heading {
  border-radius: 0 0 4px 4px;
  transition: border-radius 0.3s linear 0.2s;
}

.panel:last-child .panel-heading.active {
  border-radius: 0;
  transition: border-radius linear 0s;
}
/* #bs-collapse icon scale option */

.panel-heading a:before {
  content: '\e146';
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  font-size: 24px;
  transition: all 0.5s;
  transform: scale(1);
}

.panel-heading.active a:before {
  content: ' ';
  transition: all 0.5s;
  transform: scale(0);
}

#bs-collapse .panel-heading a:after {
  content: ' ';
  font-size: 24px;
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  transform: scale(0);
  transition: all 0.5s;
}

#bs-collapse .panel-heading.active a:after {
  content: '\e909';
  transform: scale(1);
  transition: all 0.5s;
}
/* #accordion rotate icon option */

#accordion .panel-heading a:before {
  content: '\e316';
  font-size: 24px;
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  transform: rotate(180deg);
  transition: all 0.5s;
}

#accordion .panel-heading.active a:before {
  transform: rotate(0deg);
  transition: all 0.5s;
}
</style>
<%@include file="../header.jsp"%>
<link rel="stylesheet" href="/css/bootstrap-select.css">
<script src="/js/bootstrap-select.js"></script>
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Championship - Groups</title>


</head>

<body>
	<h1 style="color: purple" class="text-center">Groups</h1>

	<c:if test="${freeParticipantsCount != 0}">
		<shiro:hasRole name="admin">
			<button class="createGroup center btn btn-lg btn-success center-block"
				data-toggle="modal" data-target="#createNewGroup">Create New
				Group</button>
		</shiro:hasRole>
	</c:if>

	<br>

    <div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
      <c:if test="${finalGroup != null}">
      <div class="panel">
        <div class="panel-heading" role="tab" id="headingOne">
          <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          Collapsible item #1
        </a>
      </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
          <div class="panel-body">
            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch.
          </div>
        </div>
      </div>
      </c:if>
      <!-- end of panel -->

      <div class="panel">
        <div class="panel-heading" role="tab" id="headingTwo">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Collapsible item #2
        </a>
      </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
          <div class="panel-body">
            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch.
          </div>
        </div>
      </div>
      <!-- end of panel -->
		
	 <c:if test="${quarterGroup != null}">
      <div class="panel">
        <div class="panel-heading" role="tab" id="headingThree">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          Quarter Finals
        </a>
      </h4>
        </div>
      <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
          <div class="panel-body">
          	
          	<display:table id="QuarterGroup" name="${quarterGroup}" class="table">
			<display:column property="id" title="ID" class="hidden id"
				headerClass="hidden" media="html"></display:column>
			<display:column title="" property="groupName" class="groupName" />
			<display:column>
				<display:table id="QuarterParticipants"
					name="${QuarterGroup.quarterFinalsParticipants}" class="table  table-hover">
					<display:column>
						<img src="../img/${QuarterParticipants.photoFileName}" height="50"
							width="50" />
					</display:column>
					<display:column title="First name" property="firstName"
						class="firstName" />
					<display:column title="Last name" property="lastName"
						class="lastName" />
						<%
							Group selectedGroup = (Group) pageContext.findAttribute("QuarterGroup");
							Participant participant = (Participant) pageContext.findAttribute("QuarterParticipants");

											int wins = 0;
											int loses = 0;

											List<Match> matches = selectedGroup.getMatches();

											for (Match m : matches) {
												if (m.getHost().getId() == participant.getId()
														|| m.getGuest().getId() == participant.getId()) {
													if (m.getWinner() != null) {
														if (m.getWinner().getId() == participant.getId()) {
															wins++;
														} else {
															loses++;
														}
													}
												}
											}
											pageContext.setAttribute("wins", wins);
											pageContext.setAttribute("loses", loses);
						%>
						<display:column title="Matches Won" sortable="true"
							class="matchesWon"> 
							${wins}
						</display:column>
						<display:column title="Matches Lost" sortable="true"
							class="matchesLost">
							 ${loses}
						</display:column>
				</display:table>
			</display:column>

			<shiro:hasRole name="admin">
				<display:column>
					<button type="button" id="deleteGroup" data-id="${QuarterGroup.id}"
						data-name="${QuarterGroup.groupName}"
						class="btn btn-danger btn-sm waves-effect waves-light"
						data-toggle="modal" data-target="#deleteGroupModal">Delete
						Group</button>
				</display:column>
			</shiro:hasRole>
		</display:table>
          	
          	
          </div>
        </div>
      </div>
      </c:if>
      <!-- end of panel -->

	  <c:if test="${stageGroup != null}">
      <div class="panel">
        <div class="panel-heading" role="tab" id="headingFour">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
          Group Stage
        </a>
      </h4>
        </div>
        
        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
          <div class="panel-body">
          	
          	<display:table id="StageGroup" name="${stageGroup}" class="table">
			<display:column property="id" title="ID" class="hidden id"
				headerClass="hidden" media="html"></display:column>
			<display:column title="" property="groupName" class="groupName" />
			<display:column>
				<display:table id="StageParticipants"
					name="${StageGroup.participants}" class="table  table-hover">
					<display:column>
						<img src="../img/${StageParticipants.photoFileName}" height="50"
							width="50" />
					</display:column>
					<display:column title="First name" property="firstName"
						class="firstName" />
					<display:column title="Last name" property="lastName"
						class="lastName" />
						<display:column title="Matches Won" sortable="true"
							property="score.matchesWon" class="matchesWon" />
						<display:column title="Matches Lost" sortable="true"
							property="score.matchesLost" class="matchesLost" />
						<display:column title="Points Made" sortable="true"
							property="score.pointsMade" class="pointsMade" />
						<display:column title="Points Taken" sortable="true"
							property="score.pointsTaken" class="pointsTaken" />
						<display:column title="Score" sortable="true"
							property="score.score" class="score" />
				</display:table>
				<br>
				<br>
				<br>
			</display:column>

			<shiro:hasRole name="admin">
					<display:column>
						<button type="button"
						class="btn btn-info btn-sm editGroup waves-effect waves-light">Edit</button>
					</display:column>
				<display:column>
					<button type="button" id="deleteGroup" data-id="${StageGroup.id}"
						data-name="${StageGroup.groupName}"
						class="btn btn-danger btn-sm waves-effect waves-light"
						data-toggle="modal" data-target="#deleteGroupModal">Delete
						Group</button>
				</display:column>
			</shiro:hasRole>
		</display:table>
          	
          	
          </div>
        </div>
      </div>
      </c:if>
      <!-- end of panel -->

    </div>
	
	<div class="modal fade" id="createNewGroup" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Create New Group</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<br>

						<!-- Text input-->
						<div class="form-group">
							<div class="col-md-offset-1 col-md-8">
								<input placeholder="Enter name of the group" id="groupName" onchange="isNameOk()" type="text"
									class="groupName form-control input-md" />
								<span class="groupSpan"></span>
							</div>
						</div>
						<div class="col-md-offset-1 col-md-8">
						There are ${freeParticipantsCount} free participants
						<label style="font-size:14px">Select number of participants</label> <select
							id="numberParticipants" class="selectpicker">
							<option value="two">2</option>
							<option value="three">3</option>
							<option value="four">4</option>
							<option value="five">5</option>
							<option value="six">6</option>
						</select>
						<span class="nubmerSpan"></span>
						</div>
						<br><br>
						</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="cancel"
						class="btn btn-primary waves-effect waves-light"
						data-dismiss="modal">Close</button>
					<button type=button  id="createGroup"
						class="btn btn-success waves-effect waves-light">Create</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="deleteGroupModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Delete Group</h4>
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
	
<script type="text/javascript">

$(document).ready(function() {
	  $('.collapse.in').prev('.panel-heading').addClass('active');
	  $('#accordion, #bs-collapse')
	    .on('show.bs.collapse', function(a) {
	      $(a.target).prev('.panel-heading').addClass('active');
	    })
	    .on('hide.bs.collapse', function(a) {
	      $(a.target).prev('.panel-heading').removeClass('active');
	    });
	});

	
 	$('.editGroup').on('click',function(){
 		var id = $(this).parent().parent().find('.id').text();
 		console.log(id);
 		window.location = "/championship/app/groups/" + id + "/edit";
 	})
		
			$('#deleteGroupModal').on('hidden.bs.modal', function() {
				$(this).removeData('bs.modal');
			});	
			
			$('#deleteGroupModal')
			.on(
					'show.bs.modal',
					function(e) {
						var groupName = $(e.relatedTarget).data('name');
						var groupId = $(e.relatedTarget).data('id');
						$('#deleteGroupModal').find('.modal-body')
						.html("Are you sure you want to delete group " + groupName);
						$('#confirmDeletion').on(
										'click',
										function() {
											window.location = "/championship/app/groups/"
													+ groupId + "/delete";
										});
					})
	
	$('#createNewGroup').on('show.bs.modal',function(e) {

		$('#createGroup').on('click',function(){
			var groupName = $('#groupName').val();
			var participantsNumbers = convertStringToInt($('#numberParticipants').val());
			isNameOk();
			if(checkGroupSpan()){
				window.location = "/championship/app/groups/createNewGroup/" + groupName+"/" + participantsNumbers;
			}
		})
		
	
		      var last_valid_selection = null;

		      $('#numberParticipants').change(function(event) {
		    	var maxNumber = ${freeParticipantsCount};
		    	var selectedNumber = convertStringToInt($(this).val());
		        if (selectedNumber > maxNumber) {
		          alert('Alert');
		          $(this).val(last_valid_selection);
		        } else {
		          last_valid_selection = $(this).val();
		        }
		      });
		
	});
	function isNameOk(){
		console.log("isNameOk");
		var groupName = $('#groupName').val();
		
		$.ajax({
		    type : "GET",
		    url : "/championship/app/groups/"  + groupName + "/checkGroupName",
		    success: function(response) {
		    	if(($(".groupSpan").text() == "")){
		    		$(".groupSpan").text(response);
		    		$(".groupSpan").css('color','red');
		    		$(".groupSpan").css('font-size','13px');
		    	}
		      },
		    error: function(err) {
	            $(".groupSpan").text("Enter group name!");
	          }
		}); 
		
		
		var regex = /^[a-zA-Z ]{3,30}$/;
		if(!regex.test($('#groupName').val())){
			$(".groupSpan").text("Name should contain only characters with lenght 3-30.");
			$(".groupSpan").css('color','red');
			$(".groupSpan").css('font-size','11px');
		} else {
			if($(".groupSpan").text() != "")
				$(".groupSpan").text("");
		}
		
		if($('#groupName').val() == ""){
			$(".groupSpan").text("Enter group name.");
			$(".groupSpan").css('color','red');
			$(".groupSpan").css('font-size','11px');
		} else {
			if($(".groupSpan").text() != "")
				$(".groupSpan").text("");
		}
	}

	function convertStringToInt(selectedString){
		var selectedInt;
		if(selectedString == "two"){
			selectedInt = 2;
		}
		if(selectedString == "three"){
			selectedInt = 3;
		}
		if(selectedString == "four"){
			selectedInt = 4;
		}
		if(selectedString == "five"){
			selectedInt = 5;
		}
		if(selectedString == "six"){
			selectedInt = 6;
		}
		return selectedInt;
	}
	
	function checkGroupSpan(){
		if($(".groupSpan").text() == ""){
			return true;
		} else {
			return false;
		}
	}		
	$('#createNewGroup').on('hidden.bs.modal', function() {
			$(this).removeData('bs.modal');
		});
	
	</script>

</body>
</html>