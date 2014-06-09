module ApplicationHelper

 def jquery_mobile_role
   controller_name == 'sessions' and params[:action] == "new" ? "dialog" : "page"
 end


 def yaml_messages(flash)
  output = ""
  flash.each do |name, msg|
   yaml_class = case name.to_s
    when "alert" then "warning"
    when "error" then "error"
    when "notice" then "success"
    else "info"
   end
   output << content_tag(:p, msg, :class => "flash-#{name} box #{yaml_class}")
  end
  output.html_safe
 end

 def model_messages(model)
  if model.errors.any?
   output = ""
   return content_tag(:p, model.errors.full_messages.to_sentence, :class => "flash-error box error").html_safe
  else
   return nil
  end
 end
 
 #Helper Zinkauflage
 #Parameter 1 Gewicht roh
 #Parameter 2 Gewicht mit Zink, netto, keine Verpackung
 def za(r,n)
	begin
		@za = ((n / r * 100) - 100).round(2)
		@za = 0 if @za < 0
	rescue
		@za = 0
	end
	return @za
 end
 
end

