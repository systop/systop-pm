module ApplicationHelper

	def check_admin
      if current_user.workgroup != 'Administrators'
        redirect_to :root
        #flash[:notice] = "Access to Logs denied"
        flash[:error] = "Access to #{params[:controller].capitalize} denied"
        #flash[:notice] = "Access to #{params[:controller].capitalize} denied"
      end
    end

end
