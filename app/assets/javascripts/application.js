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
// require sessions
// require_tree .

// require jquery.mobile-1.3.2


$( document ).ready(function() {
	
	var $barcode = $("#meiser_bundle_tag_barcode");
	
	$barcode.val('');
	$barcode.focus();
	$barcode.click(function(){
		$(this).val('');
	})
	
	$('#meiser_delivery_tag').focus();	
	//$barcode.blur(function(e){
			//alert("Focus weg");
		//$barcode.focus();
		//this.focus();
	//	this.focus();
	//	
	//})
		
	//$("#meiser_bundle_tag_barcode").on('change', function(){
		
	//});

    //$(document).keydown(function(e) {
	//	var code = e.keyCode || e.which;
		
	//	if (e.keyCode == 9) {
	//		e.preventDefault();
	//		alert('tab');
	//		$("#meiser_bundle_tag_barcode").focus();
	//	}
	//});
});

