# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#admin - production
admin = User.new email: 'admin@portal.dev',
                 name: 'Admin',
                 password: '123123',
                 password_confirmation: '123123',
                 workgroup: 'Administrators',
                 timezone: "Moscow"
admin.skip_confirmation!
admin.save!

#xander - development
# xander = User.new email: 'xanderpronin@gmail.com',
#                  name: 'Xander',
#                  password: '123123',
#                  password_confirmation: '123123',
#                  workgroup: 'Users',
#                  timezone: "Moscow"
# xander.skip_confirmation!
# xander.save!

# chuck = User.new email: 'chuck@norris.cool',
#                  name: 'Chuck Norris',
#                  password: '123123',
#                  password_confirmation: '123123',
#                  workgroup: 'Users',
#                  timezone: "Moscow"
# chuck.skip_confirmation!
# chuck.save!

# zik = User.new email: '123@123.123',
#                  name: '123test',
#                  password: '123123',
#                  password_confirmation: '123123',
#                  workgroup: 'Users',
#                  timezone: "Moscow"
# zik.skip_confirmation!
# zik.save!

settting = AdminSetting.new title: 'Logs Archive Depth',
                 alias: 'logs_archive_depth',
                 value: '70',
                 description: 'minute',
                 for: 'Log'
settting.save!

settting = AdminSetting.new title: 'Workgroups',
                 alias: 'workgroups',
                 value: 'Administrators,Users,Project Managers',
                 description: '',
                 for: 'User'
settting.save!

settting = AdminSetting.new title: 'Users roles',
                 alias: 'users_roles',
                 value: 'Developer,Manager,Designer',
                 description: '',
                 for: 'Project'
settting.save!

project = Project.new title: 'Blog',
                description: 'posting tickets'
project.save!

settting = AdminSetting.new title: 'Statuses of tasks',
                 alias: 'statuses_of_tasks',
                 value: 'Open,In progress,Closed,Blocked,Feedback',
                 description: 'List of available statuses of tasks',
                 for: 'Task'
settting.save!