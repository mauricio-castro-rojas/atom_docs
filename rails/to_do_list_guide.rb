https://www.youtube.com/watch?v=fpCRUE2vXNg

rails new todolist --css bootstrap
cd todolist
bin/dev #para lanzar el servidor con bootstrap

rails g scaffold Task name:string completed:boolean

Turbo se compone de :
Turbo Drive: Captura todas las peticiones al servidor, las cancela y hace un fetch o petición ajax sustituyendo el body.
Con esto se logra un flujo entre páginas más rápido, donde no se nota o no se alcanza a percibir la interacción.
No hace falta configurar nada, viene integrado en rails 7+

Turbo Frames: Zonas aisladas dentro de las plantillas de Rails que se pueden comunicar con el servidor y sustituir
solo esa zona

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

Despues de crear el scaffold adecuamos la vista index para crear la tarea desde esa vista sin tener que  ir a new.html

<%= form_with(model: @task, class: "row g-3") do |form| %>
    <div class="col-auto">
        <%= form.label :to_do %>
        <%= form.text_field :name %>
    </div>
    <div class="col-auto">
        <%= form.button :submit, class: "btn btn-primary mb-3" %>
    </div>
<% end %>

en el controlador el método index debe llevar las variables:
def index
   @tasks = Task.where(completed: false)
   @done_tasks = Task.where(completed: true)
   @task = Task.new

 end

 en el create del controlador pordefecto redirige a la tarea, lo que queremos es que al crearla en el index redirija
 al mismo index

 if @task.save
        format.html { redirect_to tasks_url, notice: "Task was successfully created." }

Luego queremos que en el index.html se organicen las tareas por tareas hechas y por tareas por hacer

  <h3>TO DO TASKS</h3>
<%=turbo_frame_tag "to_do_list" do %>
  <%= render @tasks %>
<% end %>

<h3>COMPLETED TASKS</h3>
<%=turbo_frame_tag "done_list" do %>
  <%= render @done_tasks %>
<% end %>


minuto 15:23

rails g stimulus check
