$(document).ready(function() {

	// override bootstrap accordion
	OverrideBootstrap.setAccordion();

	// sign in form on pageload
	FormValidation.signInValidations();

	// ingredients_recipe form on page load
	FormValidation.unitAutofill();
	FormValidation.ingredientAutofill();
	FormValidation.displayNameAutofill();
	FormValidation.ingredientValidations();
	FormValidation.sortableIngredientList();
	
	// steps form on page load
	FormValidation.stepsValidations();

	// allergen form on page load
	FormValidation.ingredientAllergensValidations();

	// recipe categroies and health groups form set
	CategoriesPreview.setCheckBoxes();

	// qualty review allergen input form set
	FormValidation.ingredientAllergensReview();

	// Content Quota form
	FormValidation.contentQuotaValidations();

	// User sign up form
	UserSignUp.appoint_self_checkbox();
	UserSignUp.nutrition_buttons();

	// Time slot calendar
	TimeSlotCalendar.set();
	TimeSlotCalendar.initiate_date_time_picker();
	SelectApptCalendar.set();

	UserSession.javascript();

	if ($("#quality-review-main-container").length >= 1){
		BasicForm.validateReview();
		BasicForm.setReviewSliders();
	} else {
		BasicForm.validate();
		BasicForm.setSliders();
	};


});