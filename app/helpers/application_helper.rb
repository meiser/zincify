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

end

