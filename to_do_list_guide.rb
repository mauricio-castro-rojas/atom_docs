https://www.youtube.com/watch?v=fpCRUE2vXNg

rails new todolist --css bootstrap
cd todolist
bin/dev #para lanzar el servidor con bootstrap

rails g scaffold Task name:string completed:boolean

rails db:migrate

#modified files:
app/controllers/tasks_controller.rb
app/views/tasks/index.html.erb
app/views/tasks/_task.html.erb
app/views/tasks/_active.turbo_stream.erb
app/assets/stylesheets/custom.scss
app/assets/stylesheets/application.bootstrap.scss
app/javascript/controllers/check_controller.js
config/routes.rb

rails g stimulus check
