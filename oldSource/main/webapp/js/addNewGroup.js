



function isNameOk(){
	
	var groupName = ('.groupName').val();
	
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
	if(!regex.test($('.groupName').val())){
		$(".groupSpan").text("Name should contain only characters with lenght 3-30.");
		$(".groupSpan").css('color','red');
		$(".groupSpan").css('font-size','11px');
	} else {
		if($(".groupSpan").text() != "")
			$(".groupSpan").text("");
	}
	
	
	
	
}

function checkGroupSpan(){
	if($(".groupSpan").text() == ""){
		return true;
	} else {
		return false;
	}
}



function validate(){
	
	if(checkGroupSpan()){
		return true;
	} else {
		return false;
	}
}