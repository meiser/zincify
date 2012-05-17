module ApplicationHelper


 def jquery_mobile_role
   controller_name == 'sessions' and params[:action] = "new" ? "dialog" : "page"
 end

end

