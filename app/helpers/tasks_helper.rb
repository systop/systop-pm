module TasksHelper
	# users/registrations
	def search_form_url
		if params[:controller] == 'projects'
  			url = project_path(@project.id)
		elsif params[:controller] == 'tasks'
  			url = task_path(@task.id)
  		elsif params[:controller] == 'users/registrations'
  			url = user_show_path(current_user.id)
		end
	end

	def search_form_project_id
		if params[:controller] == 'projects'
  			project_id = @project.id
		elsif params[:controller] == 'tasks'
  			project_id = @task.project.id
		end
	end

	def search_form_project_statuses
		if params[:controller] == 'projects'
  			@project.tasks.pluck(:status).uniq
		elsif params[:controller] == 'tasks'
  			@tasks.pluck(:status).uniq
		end
	end

	##<Task id: 18, title: "Phone ble", description: "<p><img alt=\"\" src=\"/ckeditor_assets/pictures/4/co...", author_id: 4, project_id: 4, assignee_id: 4, parent_task_id: 4, sub_task_id: nil, created_at: "2017-11-02 15:25:13", updated_at: "2017-11-02 18:09:41", status: "Closed", category_id: "2">

	def before
		# @title_before = @task.title
		# @description_before = @task.description
		# @author_before = @task.author #_id
		# @project_before = @task.project #_id
		# @assignee_before = @task.assignee #_id
		# @parent_task_before = @task.parent_task #_id
		# @sub_task_before = @task.sub_task #_id
		# @status_before = @task.status
		# @category_before = @task.category #_id

		@task_before = Task.new
		@task_before.title       = @task.title
		@task_before.description = @task.description
		@task_before.author      = @task.author #_id
		@task_before.project     = @task.project #_id
		@task_before.assignee    = @task.assignee #_id
		@task_before.parent_task = @task.parent_task #_id
		#@task_before.sub_task    = @task.sub_task #_id
		@task_before.status      = @task.status
		@task_before.category    = @task.category #_id
	end

	def after
		update = Update.new
		changed = false
		update.body = ''
		update.diff = ''

		#update.comment = 
		unless params[:task][:update][:comment].empty?
			update.comment = params[:task][:update][:comment]
			changed = true
		end

		if @task_before.status != @task.status
			update.body += "<br>Status changed from <strong>#{@task_before.status}</strong> to <strong>#{@task.status}</strong>"
			changed = true
		end

		if @task_before.title != @task.title
			update.body += "<br>title changed from <strong>#{@task_before.title}</strong> to <strong>#{@task.title}</strong>"
			changed = true
		end

		if @task_before.author != @task.author
			update.body += "<br>author changed from <strong>#{@task_before.author}</strong> to <strong>#{@task.author}</strong>"
			changed = true
		end

		if @task_before.project != @task.project
			update.body += "<br>project changed from <strong>#{@task_before.project}</strong> to <strong>#{@task.project}</strong>"
			changed = true
		end

		if @task_before.assignee != @task.assignee
			#before_task may has not assigne before update
			if @task_before.assignee.nil?
				update.body += "<br>assignee changed from Nobody to <strong>#{@task.assignee.name}</strong>"
			elsif @task.assignee.nil?
				update.body += "<br>assignee changed from <strong>#{@task_before.assignee.name}</strong> to Nobody"
			else 
				update.body += "<br>assignee changed from <strong>#{@task_before.assignee.name}</strong> to <strong>#{@task.assignee.name}</strong>"
			end
			changed = true
		end

		if @task_before.parent_task != @task.parent_task
			update.body += "<br>parent_task changed from <strong>#{@task_before.parent_task}</strong> to <strong>#{@task.parent_task}</strong>"
			changed = true
		end

		if @task_before.category != @task.category
			update.body += "<br>category changed from <strong>#{@task_before.category.title}</strong> to <strong>#{@task.category.title}</strong>"
			changed = true
		end

		if ActionController::Base.helpers.strip_tags("#{@task_before.description.html_safe}") != ActionController::Base.helpers.strip_tags("#{@task.description.html_safe}")
			update.diff += Diffy::Diff.new(ActionController::Base.helpers.strip_tags(@task_before.description), ActionController::Base.helpers.strip_tags(@task.description), options = {:include_plus_and_minus_in_html => true, :highlight_words => true}).to_s(:html)
			changed = true
		end

		update.task = @task
		update.user = current_user

		update.save if changed
	end

	def make_diff(unchanged_task, task)
		render inline: "<%= unchanged_task.status + '<hr>' + @task.status %>"
	end

end
