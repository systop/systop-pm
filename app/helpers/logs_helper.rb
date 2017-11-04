module LogsHelper

  def who_present(id)
    if User.exists?(id)
      link_to User.find(id).name, user_show_path(id), :class => "btn-link"
    else
      "User was deleted"
    end
  end

  def check_archive_depth
      #byebug
      logs = Log.all
      depth = AdminSetting.where(:alias == 'logs_archive_depth')[0].value.to_i
      if logs.size > depth
        diff = logs.size - depth
        for i in 0..(diff-1)
          logs[i].delete
        end
      end
  end

  def log_record(head, user_id)
    log = Log.new
    #byebug
    log.who = user_id
    log.head = head
    log.level = 1
    log.save
    check_archive_depth
  end

end
