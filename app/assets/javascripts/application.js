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
// require_tree .


if (typeof history.pushState == "undefined") {
    alert("PushState not supported by Browser");// pushState is supported!
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
  $("#datepicker").datepicker( "option", "dateFormat", "DD, d MM, yy" );

  $("#delivery_customer_id").chosen();
  $("#traverse_name").chosen().change( function(e){
   console.log("Do it");
   //window.location = $(this).val();
  });



});

