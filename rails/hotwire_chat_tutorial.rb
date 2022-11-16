rails new chat --skip-javascript

#add to the gemfile and run bundle:

gem "hotwire-rails" #includes the full setup for turbo and stimulus

#The hotwire install command will turn on Redis backing for handling websockets with ActionCable at the importmap needed for auto loading
#Stimulus controllers and a few other tweaks
in terminal:

bundle
rails hotwire:install

Notes Important!!
rails 7 comes with stimulus and turbo rails gems so .... just run


rails new chat

the app will use two models room and message

rails g scaffold room name:string

one room has many messages

rails g model message room:references content:text

we'll use a full scaffold for the room model to give us the basic editing interface, but only use the model generator for message
since it need much less

rails db:migrate


resources :rooms do
    resources :messages
end

room model:

class Room < ApplicationRecord
  has_many :messages
end

create messages controller
