// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.datepicker-de
//= require jquery-ui-timepicker-addon
//= require chosen.jquery
//= require jquery_nested_form
// require_tree .


if (typeof history.pushState == "undefined") {
    //alert("PushState not supported by Browser");// pushState is supported!
}

$(document).ready(function() {
    setTimeout(function() {
        $('.flash-alert,.flash-notice,.flash-error,.flash-info').fadeOut();
    }, 5000);


  // create a convenient toggleLoading function
  var toggleLoading = function() { $("#loading").toggle() };
  $("#baan_printer")
  .bind("ajax:loading", toggleLoading)
  .bind("ajax:complete", toggleLoading);

  
  $("#datepicker").datepicker();
  //$("#datepicker").datepicker( "option", "dateFormat", "DD, d MM, yy" );

  $("#delivery_customer_bpid,#booking_traverse_id,#booking_delivery_id,#completion_sort_list_id").chosen({
    no_results_text: "Keine Einträge in der Datenbank"

  });
  //$("#delivery_cash_payer").chosen({
 //	no_results_text: "Keine Einträge in der Datenbank"
//});
	
  $("#delivery_cash_payer_id").bind('cash_payer_selected',function(e){
	console.log("Barzahler wurde ausgewählt");
	$(this).chosen();
	$(this).attr('disabled', false);
	$(this).trigger("liszt:updated");
  });
  
  $("#delivery_cash_payer_id").bind('cash_payer_not_selected',function(e){
	console.log("Barzahler nicht mehr ausgewählt");
	$("#delivery_cash_payer_id").attr('disabled', true);
	$("#delivery_cash_payer_id").trigger("liszt:updated");
	
	//$("#delivery_cash_payer_id").nextAll().remove();
  });
  
  $("#delivery_customer_bpid").change( function(e){
   if ($(this).val()==280000142){
	$("#delivery_cash_payer_id").trigger('cash_payer_selected');
   } else {
	$("#delivery_cash_payer_id").trigger('cash_payer_not_selected');
   };
  });

  $("#delivery_customer_bpid").trigger("change");
  

  // Fertigmeldung
    $('#completion_weight').focus(function() {
        $(this).val(Math.floor(Math.random() * 2000));
    //    if(confirm("Sind die Daten korrekt")){
	//		$("#new_completion").submit();
	//	}
	//$("#new_completion").submit();
    });



});

