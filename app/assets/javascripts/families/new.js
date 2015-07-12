

var Families = {
	new: function(){
		$('input:radio[name="appointment_focus"]').change(
		    function(){
		      if ( $(this).val() === "user-form" ) {
		      	$(".user-form").removeClass("hidden");
		      	$(".new-user-form").addClass("hidden");
		      } else {
		      	$(".new-user-form").removeClass("hidden");
		      	$(".user-form").addClass("hidden");
		      }
		    }
		); 
		$('.user-form input:radio[name="pregnancy"]').change(
		    function(){
		      if ( $(this).val() === "yes" ) {
		      	$(".user-form .due-date-container").removeClass("hidden");
		      } else {
		      	$(".user-form .due-date-container").addClass("hidden");
		      }
		    }
		); 
		$(".new-user-form select[name='user[date_of_birth(1i)]']").change(function() {
		  if ( parseInt($(this).val()) < moment().subtract(18, "years").year()){
		   	$(".new-user-form .pregnancy-container").removeClass("hidden");
		  } else { 
				$(".new-user-form .pregnancy-container").addClass("hidden");
		  }
		});

		$('.new-user-form input:radio[name="pregnancy"]').change(
		    function(){
		      if ( $(this).val() === "yes" ) {
		      	$(".new-user-form .due-date-container").removeClass("hidden");
		      } else {
		      	$(".new-user-form .due-date-container").addClass("hidden");
		      }
		    }
		);  
	}
}        
// ")
// <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">