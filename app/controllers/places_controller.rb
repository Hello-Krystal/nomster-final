# lesson 4: build a new controller for the root page to live and have the root go to the index action
class PlacesController < ApplicationController
  #Before filters are code that executes before the code in our controller runs
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @places = Place.all
    #Lesson 12 challenge step 3 - paginate places alphabetically, only showing 5 places per page
    @places = Place.all.order('id DESC').paginate(page: params[:page], per_page: 5)
  end

  def new  #config/routes.rb allows us to create a new place
    @place = Place.new
  end

  def create #creates place connected with user and sends def place_params values to the database
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
 
  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end
  end

  def update
  @place = Place.find(params[:id])

    if @place.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @place.destroy
    redirect_to root_path
  end

  private

  def place_params #pulls the values of name, description and address from the place form
    params.require(:place).permit(:name, :description, :address)
  end

end

