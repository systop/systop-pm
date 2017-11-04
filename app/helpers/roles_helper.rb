module RolesHelper

	def check_permission
      #byebug
      deny_access unless role_condition
    end

    def role_condition
    	current_user.workgroup == 'Administrators' || Role.where(user: current_user, project: project_id_here, title: "Manager").exists?
    end

    def project_id_here
    	case params
	    	when -> (h) {h.has_key? :id} #destroy
	    		Role.find(params[:id]).project.id
	    	when -> (h) {h.has_key? :project_id} #add_user#new
	    		params[:project_id]
	    	when -> (h) {h.has_key? :role} #add_user#create
	    		params[:role][:project_id]
    	end
    end

    def deny_access
    	redirect_to :root
        flash[:error] = "Access to Roles denied"
    end

    def redirect_after_destroy(project_id_for_redirect)
    	if current_user.workgroup == 'Administrators'
    		redirect_to roles_url, notice: 'Role was successfully destroyed. Admin redirected to list of Roles'
    	else
    		#byebug
    		redirect_to project_path(project_id_for_redirect), notice: 'Role was successfully destroyed.'
    	end
    end

end
      #destroy<ActionController::Parameters {"_method"=>"delete", "authenticity_token"=>"JE8DcWSarez6cKDnZuza9B1PRtpJzQBwitlf5UldX1uOf0z+cRHKnzQNrejIM+dEabsv+xKTgVJd6E2cmMwP7g==", "controller"=>"roles", "action"=>"destroy", "id"=>"8"} permitted: false>
      #add_user#new<ActionController::Parameters {"project_id"=>"4", "controller"=>"roles", "action"=>"new"} permitted: false>
      #add_user#create<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"+d2jcCxnR2rODIMXetjHfdGOAQxv1Gu9lar1nvHlsQ9T7ez/OewgGQBxjhjUB/rNpXpoLTSK6p9Cm+fnIHThug==", "role"=>{"title"=>"Manager", "description"=>"", "project_id"=>"4", "user_id"=>"4"}, "commit"=>"Create Role", "controller"=>"roles", "action"=>"create"} permitted: false>
