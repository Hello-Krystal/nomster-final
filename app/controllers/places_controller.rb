# lesson 4: build a new controller for the root page to live and have the root go to the index action
class PlacesController < ApplicationController

  def index
    @places = Place.all
    #Lesson 12 challenge step 3 - paginate places alphabetically, only showing 5 places per page
    @places = Place.all.order('id DESC').paginate(page: params[:page], per_page: 5)
  end

  def new  #config/routes.rb allows us to create a new place
    @place = Place.new
  end

   def create
    Place.create(place_params) #sends def place_params values to the database
    redirect_to root_path #the page we want to send the user to
  end

  private

  def place_params #pulls the values of name, description and address from the place form
    params.require(:place).permit(:name, :description, :address)
  end

end

