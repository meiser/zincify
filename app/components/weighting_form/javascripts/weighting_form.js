{
  // called by the server as the result of executing the endpoint :scale_poll
  showWeight: function(available, message){
  	myForm = this;
	var task = new Ext.util.DelayedTask(function(){
		myForm.scalePoll();
	});
	
	weightField = this.form.findField("weight_brutto");
	weightField.reset();
	weightField.setDisabled(available);
	console.log(message);
	
	task.delay(3000);
	
  }
}