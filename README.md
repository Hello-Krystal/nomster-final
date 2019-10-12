# README

# Concept: model view controller

## Creating Databases

create columns in database by whats called running the migration
`` rake db:migrate ``

if you make a mistake you can undo the last migration by doing
`` rake db:rollback ``
then you can adjust the migration and run the migration again

## $ Rails console
we can add an item to our database by using the rails console
Place.create(name: 'ENTER NAME HERE', address: 'ENTER ADDRESS HERE', description: 'ENTER DESCRIPTION 
HERE')

## $ Rails generate devise

`` $ rails generate devise:install ``

`` Some setup you must do manually if you haven't yet:
  1. Ensure you have defined default URL options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:
       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
     In production, :host should be set to the actual host of your application.
  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:
       root to: "home#index"
  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:
       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>
  4. You can copy Devise views (for customization) to your app by running:
       rails g devise:views ``

# CHALLENGES

# Lesson 39: Adding an Image Upload Feature for Places

In this activity, you will add the ability to upload images to your Nomster application. We will guide you through adding a new database model and point you to the CarrierWave Ruby gem, which will make image uploading possible.

## Setting Up the Pipeline for Photos

Jump into the terminal and run the following command
``` $ rails generate model photo ```

This will create a migration file, which lets Rails know what new table(s) to create in your database. 

[db/migrate/YYYYMMDD_create_photos.rb]

### Mini-challenge: open new photo migration file and add a caption and place_id 

``class CreateComments < ActiveRecord::Migration[5.0] 
      def change
        create_table :photos do |t|
          t.text :caption
          t.integer :place_id
          t.timestamps
        end``

On the bottom of the migration page add some indexes to ensure my lookups between the different database tables are fast.

`` add_index :photos, [:user_id, :place_id]
    add_index :photos, :place_id
  end ``

In the terminal run the migration
``` $ rake db:migrate ```

### Mini-Challenge: update model to establish its relationship to other models.

In [app/models/photo.rb] update model to establish its relationship to other models. 

`` class Photos < ApplicationRecord
    belongs_to :user
    belongs_to :place
  end ``

In [app/models/user.rb] add
`` has_many :photos ``

In [app/models/place.rb] add
`` has_many :photos ``

git commit

## Adjust Places Controller for Photos

[app/controllers/places_controller.rb]

`` def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photos = Photos.new 
  end ``

## Add the Form on the Show Page

[app/views/places/show.html.erb]

``<div class="clear"></div>
<%= simple_form_for @photos, url: '#' do |f| %>
  <%= f.input :caption %>
  <%= f.input :picture %>
  <%= f.submit "Add a Photo", class: 'btn btn-primary' %>
<% end %>``

Add the following to CSS
[app/assets/stylesheets/master.scss]

.clear {
  clear: both;
}

git commit

## Create a controller for photos

`` rails generate controller photos ``

### Mini-Challenge: Adjusting the Routes for Photos

To add/change URLS in web app[config/routes.rb]

Run rake routes to confirm configuation is correct

``place_photos POST   /places/:place_id/photos(.:format) photos#create``

### Mini-Challenge: Adjusting the form

Adjust form to include the URL that points to the place_photos_path

`` <%= simple_form_for @photo, url: place_photos_path(@place) do |f| %>
    <div class="clear">
      <%= f.input :caption %>
      <%= f.input :picture %>
      <%= f.submit "Add a Photo", class: 'btn btn-primary' %>
    </div>
  <% end %>  ``

### Mini-Challenge: Setting Up the Create Action

[app/controllers/photos_controller.rb]

``class PhotosController < ApplicationController
  before_action :authenticate_user!
  def create
    @place = Place.find(params[:place_id])
    @photo = Photo.new
  end
end``

End product photos_controller.rb
``class PhotosController < ApplicationController
  before_action :authenticate_user!
  def new
    @place = Place.find(params[:place_id])
    @photo = Photo.new
  end
  def create
    @place = Place.find(params[:place_id])
    @photo = Photo.new(user: current_user)
    @photo.update_attributes(photo_params)
    @photo.save
    @place.photos << @photo
    redirect_to place_path (@place)
  end
  private
  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end 
end ``
