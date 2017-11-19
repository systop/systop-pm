module ApplicationHelper

	def check_admin
      if current_user.workgroup != 'Administrators'
        redirect_to :root
        #flash[:notice] = "Access to Logs denied"
        flash[:error] = "Access to #{params[:controller].capitalize} denied"
        #flash[:notice] = "Access to #{params[:controller].capitalize} denied"
      end
    end

    def link_to_add_fields(name, f, type)
	  new_object = f.object.send "build_#{type}"
	  id = "new_#{type}"
	  fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
	    render(type.to_s + "_fields", f: builder)
	  end
	  link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

end
