

Kindrdfood = Kindrdfood || {};


Kindrdfood.dateTimePickers = Kindrdfood.dateTimePickers || {};

Kindrdfood.dateTimePickers.dateTimePicker = {
  init: function(){
  	$("#datetimepicker, .datetimepicker").datetimepicker({ sideBySide: true, allowInputToggle: true });

	},
	dateOnlyInit: function(){
		$('#datepicker').datetimepicker({
      format: 'DD/MM/YYYY',
      allowInputToggle: true
    });
	}
}