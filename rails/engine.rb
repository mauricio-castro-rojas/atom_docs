rails plugin new blorgh --mountable

#ERROR:
#You have one or more invalid gemspecs that need to be fixed.
#The gemspec at /Users/mauro/Documents/blorgh/blorgh.gemspec is not valid. Please fix this gemspec.
#The validation error was 'metadata['homepage_uri'] has invalid link: "http://localhost:3000"'

#HOW TO FIX IT: -> put a dummy web direction

#at blorgh.gemspec

  spec.homepage    = 'http://website.com'
  spec.summary     = "Blorgh engine"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://website.com"
  spec.metadata["changelog_uri"] = "http://website.com"


#from the blorghs engine root
bin/rails generate scaffold article title:string text:text

bin/rails db:migrate

== 20220717172340 CreateBlorghArticles: migrating =============================
-- create_table(:blorgh_articles)
   -> 0.0057s
== 20220717172340 CreateBlorghArticles: migrated (0.0057s) ====================

#bin/rails server in test/dummy. When you open
#http://localhost:3000/blorgh/articles you will see the default scaffold that has been generated.
#Click around! You've just generated your first engine's first functions.


#ERROR blorgh % cd test
#mauro@Hernans-MacBook-Pro test % cd dummy
#mauro@Hernans-MacBook-Pro dummy % rails s
#Could not find server ''.
#Run `bin/rails server --help` for more options.

#Solve it: add gem "puma", "~> 5.0" to the gemfile and run bundle install

bin/rails generate model Comment article_id:integer text:text
bin/rails db:migrate

#To show the comments on an article, edit app/views/blorgh/articles/show.html.erb and add this line before the "Edit" link:

#<h3>Comments</h3>
#<%= render @article.comments %>

#This line will require there to be a has_many association for comments defined on the Blorgh::Article model, which
#there isn't right now. To define one, open app/models/blorgh/article.rb and add this line into the model:

has_many :comments

#Next, there needs to be a form so that comments can be created on an article. To add this, put this line underneath
#the call to render @article.comments in app/views/blorgh/articles/show.html.erb:

#<%= render "blorgh/comments/form" %>

#Next, the partial that this line will render needs to exist. Create a new directory at
#app/views/blorgh/comments and in it a new file called _form.html.erb which has this content to create
#the required partial:

<h3>New comment</h3>
<%= form_with model: [@article, @article.comments.build] do |form| %>
  <p>
    <%= form.label :text %><br>
    <%= form.text_area :text %>
  </p>
  <%= form.submit %>
<% end %>

#When this form is submitted, it is going to attempt to perform a POST request to a route of
#/articles/:article_id/comments within the engine. This route doesn't exist at the moment, but can
#be created by changing the resources :articles line inside config/routes.rb into these lines:

resources :articles do
  resources :comments
end

#This creates a nested route for the comments, which is what the form requires.

#The route now exists, but the controller that this route goes to does not. To create it,
# run this command from the engine root:

bin/rails generate controller comments

#The form will be making a POST request to /articles/:article_id/comments, which will correspond with the create
#action in Blorgh::CommentsController. This action needs to be created, which can be done by putting the
#following lines inside the class definition in app/controllers/blorgh/comments_controller.rb:

def create
  @article = Article.find(params[:article_id])
  @comment = @article.comments.create(comment_params)
  flash[:notice] = "Comment has been created!"
  redirect_to articles_path
end

private
def comment_params
  params.require(:comment).permit(:text)
end


# To show the comments Create a new file at app/views/blorgh/comments/_comment.html.erb and put this line inside it:

<%= comment_counter + 1 %>. <%= comment.text %>

#The comment_counter local variable is given to us by the <%= render @article.comments %> call,
#which will define it automatically and increment the counter as it iterates through each comment.
#It's used in this example to display a small number next to each comment when it's created.

#Mounting the engine:
# outside of the engine directory:
rails new unicorn

#Because you are developing the blorgh engine on your local machine, you will need to specify
#the :path option in your Gemfile:

gem 'blorgh', path: 'engines/blorgh'

# move the blorgh folder to the engines/blorgh inside unicorn app
#Then run bundle to install the gem.

#To make the engine's functionality accessible from within an application, it needs
#to be mounted in that application's config/routes.rb file:

mount Blorgh::Engine, at: "/blog"

#This line will mount the engine at /blog in the application. Making it accessible at
#http://localhost:3000/blog when the application runs with bin/rails server.

# before running rails s we must copy migrations
bin/rails blorgh:install:migrations

Copied migration 20220719123833_create_blorgh_articles.blorgh.rb from blorgh
Copied migration 20220719123834_create_blorgh_comments.blorgh.rb from blorgh

bin/rails db:migrate

Sprockets::Rails::Helper::AssetNotPrecompiledError in Blorgh::Articles#index
Showing /Users/mauro/Documents/unicorn/engines/blorgh/app/views/layouts/blorgh/application.html.erb where line #8 raised:

Asset `blorgh/application.css` was not declared to be precompiled in production.
Declare links to your assets in `app/assets/config/manifest.js`.

  //= link blorgh/application.css

and restart your server

#how to solve it: add this line to manifest.js at unicorn/app/assets/config
//= link blorgh/application.css

bin/rails generate model user name:string

bin/rails db:migrate

#The author_name text field needs to be added to the app/views/blorgh/articles/_form.html.erb partial
#inside the engine. This can be added above the title field with this code:

<div class="field">
  <%= form.label :author_name %><br>
  <%= form.text_field :author_name %>
</div>

#update our Blorgh::ArticlesController#article_params method to permit the new form parameter:

def article_params
  params.require(:article).permit(:title, :text, :author_name)
end

#The Blorgh::Article model should then have some code to convert the author_name field into an actual User
#object and associate it as that article's author before the article is saved.
#It will also need to have an attr_accessor set up for this field, so that the setter and getter methods
#are defined for it.

#Add the attr_accessor for author_name, the association for the author and the before_validation
#call into app/models/blorgh/article.rb. The author association will be hard-coded
#to the User class for the time being.

attr_accessor :author_name
belongs_to :author, class_name: "User"

before_validation :set_author

private
  def set_author
    self.author = User.find_or_create_by(name: author_name)
  end

#By representing the author association's object with the User class, a link is established
# between the engine and the application. There needs to be a way of associating the records in
#the blorgh_articles table with the records in the users table. Because the association is called author,
#there should be an author_id column added to the blorgh_articles table.

#To generate this new column, run this command within the engine:

bin/rails generate migration add_author_id_to_blorgh_articles author_id:integer

#This migration will need to be run on the application. To do that, it must first be copied using this command:
bin/rails blorgh:install:migrations
bin/rails db:migrate

#Finally, the author's name should be displayed on the article's page. Add this code above the
#"Title" output inside app/views/blorgh/articles/show.html.erb:

<p>
  <b>Author:</b>
  <%= @article.author.name %>
</p>

#By default, the engine's controllers inherit from Blorgh::ApplicationController. So, after making this change
#they will have access to the main application's ApplicationController, as though they were part of the main application.
module Blorgh
  class ApplicationController < ::ApplicationController
  end
end

#4.4.1 Setting Configuration Settings in the Application
#The next step is to make the class that represents a User in the application customizable
#for the engine. This is because that class may not always be User, as previously explained. To make this
#setting customizable, the engine will have a configuration setting called author_class that will be used to
# specify which class represents users inside the application.

#To define this configuration setting, you should use a mattr_accessor inside the Blorgh
#module for the engine. Add this line to lib/blorgh.rb inside the engine:

mattr_accessor :author_class

#The next step is to switch the Blorgh::Article model over to this new setting. Change the belongs_to
#association inside this model (app/models/blorgh/article.rb) to this:

belongs_to :author, class_name: Blorgh.author_class

#The set_author method in the Blorgh::Article model should also use this class:

self.author = Blorgh.author_class.constantize.find_or_create_by(name: author_name)

#To save having to call constantize on the author_class result all the time, you could instead just
#override the author_class getter method inside the Blorgh module in the lib/blorgh.rb file to always
#call constantize on the saved value before returning the result:

def self.author_class
  @@author_class.constantize
end

#This would then turn the above code for set_author into this:


#Since we changed the author_class method to return a Class instead of a String,
#we must also modify our belongs_to definition in the Blorgh::Article model:

belongs_to :author, class_name: Blorgh.author_class.to_s

#To set this configuration setting within the application, an initializer should be used. By using an initializer,
#the configuration will be set up before the application starts and calls the engine's models, which may depend on this configuration setting existing.

#Create a new initializer at config/initializers/blorgh.rb inside the application where the blorgh engine is
#installed and put this content in it:

Blorgh.author_class = "User"
