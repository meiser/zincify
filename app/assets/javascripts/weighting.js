$(document).ready(function() {  
	$(document).on( "click", "#weighting_selected_all", function() {
	  $('.weighting_selected').prop('checked', this.checked);
	  if (this.checked == false){
			$("#change_item").prop("disabled", "disabled");
			$("#item_base_data_all_selected").prop("disabled", "disabled");
		} else {
			$("#change_item").removeAttr("disabled");
			$("#item_base_data_all_selected").removeAttr("disabled");
		};
	});
	
	$(document).on( "click", "#change_item", function(e) {
		e.preventDefault();
			var current_item = $("#item_base_data_all_selected").val();
			$(".weighting_selected:checked").each(function(){
				var x = $(this).attr("id");
				$("#"+x+"_dropdown").val(current_item);
			});
	});
	
	
	$(document).on( "click", ".weighting_selected", function(e) {
		var checked_records  = $(".weighting_selected:checked").length;
		if($(".weighting_selected").length == checked_records) {
			$("#weighting_selected_all").prop("checked", "checked");
		} else {
			$("#weighting_selected_all").removeAttr("checked");
		}
		if (checked_records > 0){	
			$("#change_item").removeAttr("disabled");
			$("#item_base_data_all_selected").removeAttr("disabled");

		} else {
			$("#change_item").attr("disabled", "disabled");
			$("#item_base_data_all_selected").attr("disabled", "disabled");
		}
	});
	
	$(document).on("ajax:beforeSend", "#change_item_form", function() {
		var mask = new Ext.LoadMask(Ext.get('set_items_window'), {msg:"Please wait..."});
        mask.show();
	});
	
	$(document).on("ajax:success", "#change_item_form", function() {
		var form = Ext.get('set_items_window');
		form.unmask();
	});
	
	
});