mkdir quote-editor
cd quote-editor

rails new . \
  --css=sass \
  --javascript=esbuild \
  --database=postgresql \
  --force

bin/setup
bin/dev

bin/rails g system_test quotes
# modified path: /quote-editor/test/system/quotes_test.rb
touch test/fixtures/quotes.yml

#run tests:
bin/rails test:system


#it will fail cause we don't have the model created

rails generate model Quote name:string
#As we already generated the fixture file, type "n" for "no" when asked to overrid it.

# app/models/quote.rb
# add a validation to the model

# db/migrate/XXXXXXXXXXXXXX_create_quotes.rb
# add null: false as a constraint to our name attribute to enforce the validation
# and ensure we will never store quotes with an empty name in the database

#run migration
bin/rails db:migrate

#add controller
bin/rails generate controller Quotes

#add the seven routes of the CRUD for our Quote resource:
# config/routes.rb
resources :quotes


## app/controllers/quotes_controller.rb
#Now that the routes are all set, we can write the corresponding controller actions


#The views we will add already have a few CSS class names. We will build our design
#system and create the corresponding CSS files in the next chapter, so, for now,
#you can just copy the markup

app/views/quotes/index.html.erb

#We follow the Ruby on Rails conventions for the Quotes#index page by rendering
#each quote in the @quotes collection from the partial

app/views/quotes/_quote.html.erb

#The markup for the Quotes#new and Quotes#edit pages
#Note that the only difference between the two pages is the content of the <h1> tag.

app/views/quotes/new.html.erb and app/views/quotes/edit.html.erb

#Once again, we will follow Ruby on Rails conventions by rendering the form from
#the app/views/quotes/_form.html.erb file. That way, we can use the same partial
#for both the Quotes#new and the Quotes#edit pages.

app/views/quotes/_form.html.erb

#The autofocus option is here to focus the corresponding input field when the
#form appears on the screen, so we don't have to use the mouse and can type
#directly in it. Notice how the markup for the form is simple? It's because we
#are going to use the simple_form gem. To install it, let's add the gem to our
#Gemfile.

gem "simple_form", "~> 5.1.0"

bundle install
bin/rails generate simple_form:install


#The role of the simple_form gem is to make forms easy to work with. It also
# helps keep the form designs consistent across the application by making sure
#we always use the same CSS classes. Let's replace the content of the
#configuration file and break it down together:

config/initializers/simple_form.rb

#The wrappers configuration lists the input wrappers that we can use in our
#application. For example, calling f.input :name for the Quote model with the
#:default wrapper will generate the following HTML:

<div class="form__group">
  <label class="visually-hidden" for="quote_name">
    Name
  </label>
  <input class="form__input" type="text" name="quote[name]" id="quote_name">
</div>

#Can you see how the CSS classes of the generated HTML match our wrapper's
#definition? That's what simple form does! It helps us define wrappers for
#forms that we can reuse in our application very easily, making our forms easy
#to work with.

#The default configuration part contains options to configure the submit
#buttons' default classes, the labels, the way checkboxes and radio buttons are
#rendered... The most important one here is the config.default_wrapper = :default.
#It means that when we type f.input :name without specifying a wrapper, the :default
#wrapper seen above will be used to generate the HTML.

#Simple form also helps us define text for labels and placeholders in another
#configuration file:

config/locales/simple_form.en.yml

=begin
The configuration above tells simple form that the placeholder for names inputs
on quote forms should be "Name of your quote" and that the label for quote names
inputs should be "Name".

The last lines under the :helpers key can be used without the simple form gem,
but we will still add them there as they are related to forms. They define the
text of the submit buttons on quote forms:

When the quote is a new record, the submit button will have the text
"Create quote"
When the quote is already persisted in the database, the submit button will
have text "Update quote"

=end


=begin
The markup for the Quotes#show page
For now, it will be almost empty, containing only a title with the name of
the quote and a link to go back to the Quotes#index page.
=end

app/views/quotes/show.html.erb

=begin
It seems like we just accomplished our mission. Restart the server!
Let's make sure our
test passes by running bin/rails test:system. They pass!
=end

bin/dev
bin/rails test:system

=begin
Note: When launching the system tests, we will see the Google Chrome browser
open and perform the tasks we created for our quote system test. We can use
the headless_chrome driver instead to prevent the Google Chrome window from
opening:
=end
test/application_system_test_case.rb


=begin
Turbo Drive: Form responses must redirect to another location
The app works as expected unless we submit an empty form. Even if we have a
presence validation on the name of the quote, the error message is not displayed
as we could expect when the form submission fails. If we open the console in our
dev tools, we will see the cryptic error message "Form responses must redirect
to another location".

This is a "breaking change" since Rails 7 because of Turbo Drive. We will
discuss this topic in-depth in Chapter 3 dedicated to Turbo Drive. If you ever
 encounter this issue, the way to fix it is to add status: :unprocessable_entity
 to the QuotesController#create and QuotesController#update actions when the
  form is submitted with errors:
=end

app/controllers/quotes_controller.rb
# Add `status: :unprocessable_entity` here
      render :new, status: :unprocessable_entity

# Add `status: :unprocessable_entity` here
     render :edit, status: :unprocessable_entity

=begin
Seeding our application with development data
When we launched our server for the first time, we didn't have any quotes on
our page. Without development data, every time we want to edit or delete a quote,
 we must create it first.

While this is fine for a small application like this one, it becomes annoying
for real-world applications. Imagine if we needed to create all the data manually
 every time we want to add a new feature. This is why most Rails applications
 have a script in db/seeds.rb to populate the development database with fake
 data to help set up realistic data for development.

In our tutorial, however, we already have fixtures for test data.

We will reuse the data from the fixtures to create our development data.
It will have two advantages:

We won't have to do the work twice in both db/seeds.rb and the fixtures files
We will keep test data and development data in sync

If you like using fixtures for your tests, you may know that instead of
running bin/rails db:seed you can run bin/rails db:fixtures:load to create
development data from your fixtures files. Let's tell Rails that the two
commands are equivalent in the db/seeds.rb file:

=end

db/seeds.rb

puts "\n== Seeding the database with fixtures =="
system("bin/rails db:fixtures:load")


=begin
Running the bin/rails db:seed command is now equivalent to removing all the
quotes and loading fixtures as development data. Every time we need to reset a
clean development data, we can run the bin/rails db:seed command:

bin/rails db:seed
=end


=begin
Organizing CSS files in Ruby on Rails
In this chapter, we will write some CSS using the BEM methodology to create
a nice design system for our application.
=end

https://en.bem.info/methodology/


=begin
Using our CSS architecture on our quote editor
The mixins folder
The mixins folder is the smallest of all. It will only contain one file called
_media.scss in which we will define the breakpoints of our media queries. In
our application, we will have only one breakpoint that we will call
tabletAndUp
=end

app/assets/stylesheets/mixins/_media.scss

=begin
When writing CSS, we will first write the CSS for mobile
Then we might want to have some overrides for tablets and larger screens sizes.
In that case, using our media query makes things very easy.

This is what we call mobile first approach. First, we define our CSS for the
smallest screen sizes (mobiles), then add overrides for larger screen sizes.
It's a good practice to use this kind of mixin in our Sass code. If we later
want to add more breakpoints, such as laptopAndUp or desktopAndUp, it becomes
very easy to do so.

It also clarifies what the breakpoint corresponds to as tabletAndUp is easier
to read than 50rem.

It also helps us keep our code DRY by avoiding repeating the magic 50rem
number everywhere

Imagine that we want to change 50rem to 55rem at some point. This would be a
maintenance nightmare, as we would have to change the value in all components.

Last but not least, having a curated list of breakpoints in a single place
helps us choose the most relevant one a limit our options!

There was quite a lot to say for this first CSS file, but it is a really
useful one. Our quote editor must be responsive, and this is a simple yet
powerful implementation for breakpoints.
=end


=begin
The configuration folder
One of the most important files is the variables file to make a robust design
system. This is where we will choose beautiful colors, readable fonts and make
a spaces scale to ensure consistent spacing.

Creating a variables file might look a bit magical throwing variables around,
but rules like the multiple of 8 rule for spacings and font sizes to help us
build the variables file. For font sizes and spaces, I almost always use the
same scales.

When creating a website from scratch, I often choose a "personality" that
will guide the choice of fonts and colors.

Enough design talk; let's start building this variable file!

First, let's start with everything we need for our text design, such as fonts
families, colors, sizes, and line heights.
=end

app/assets/stylesheets/config/_variables.scss

=begin
The next step in designing our application is to apply those variables to global
styles i.e., styles that are all the same in the whole application. These
styles should represent reasonable styling defaults for HTML tags. We should
not use any CSS classes here. For example, in the file below, we:

Style default text
Style default links
Reset all margins and paddings to zero as it should be layout classes
responsibility
Those changes are global to all the pages of our application.
They can be easily overridden because they are only applied to HTML tags and
thus, have a low specificity.
=end

app/assets/stylesheets/config/_reset.scss

=begin
Now that we have our global style in place, we can design our individual
components.

The components folder
The components folder will contain styles for our individual components.
Now that we have a solid set of variables, designing components will be
straightforward.

Let's start by, believe it or not, our most complex components: buttons.
We will start with the base .btn class and then add four modifiers for the
different styles:
with Sass, the & sign corresponds to the selector in which the & is directly
 nested. In our case &:hover, will be translated by Sass to .btn:hover in CSS.

We then need to add four modifiers to create the four variants of the
button component we will need in our application:

=end

app/assets/stylesheets/components/_btn.scss
app/assets/stylesheets/components/_quote.scss

=begin
The .quote component is just a flex container with a .quote__actions element
containing the buttons to edit and delete the quote. Thanks to the BEM
methodology, our CSS files are very clean!

Let's now design our inline forms. In the previous chapter, we defined the
Simple Form wrappers that will be used for the forms in our application. We
will need two components to design our forms: .form and .visually-hidden.
=end

app/assets/stylesheets/components/_form.scss

app/assets/stylesheets/components/_visually_hidden.scss

=begin
You might wonder why we need a .visually-hidden component to hide the input
 label and not simply remove it from the DOM or use display: none;. For
 accessibility purposes, all form inputs should have labels that can be
 interpreted by screen readers even if they are not visible on the web page.
 This is why most applications use a .visually-hidden component. We don't have
 to learn the CSS by heart as we can steal the component from the Bootstrap 
 source code.

No form would be complete without a way to display error messages. Let's add
the simple component to display errors in red:
=end

app/assets/stylesheets/components/_error_message.scss

=begin
The layouts folder
The container is a layout that almost every web application has. It is used to
 center content on the page and limit its maximum width. We will use it on every
 page of our quote editor. Here is the implementation we will use:

 The header is a layout we will use twice in this tutorial on the Quotes#index
 and the Quotes#show page. It will contain the title of the page and the main
 action button:
=end

// app/assets/stylesheets/layouts/_container.scss

// app/assets/stylesheets/layouts/_header.scss


=begin
Now that we have all our layouts, we wrote all the necessary CSS for our
application. We just have to import all those files in the manifest file for
Sass to bundle them.

The manifest file
Finally, we have to import all of those CSS files in our application.sass.scss
for all our design files to be added to a single compiled CSS file.
=end
app/assets/stylesheets/application.sass.scss
