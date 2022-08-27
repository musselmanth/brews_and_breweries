class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
  end

  def show
    @brewery = Brewery.find(params[:brewery_id])
  end

  def new
  end

  def edit
    @brewery = Brewery.find(params[:brewery_id])
  end

  def create
    Brewery.create(brewery_params)
    redirect_to "/breweries"
  end

  def update
    brewery = Brewery.find(params[:brewery_id])
    brewery.update(brewery_params)
    redirect_to "/breweries/#{brewery.id}"
  end

  def brewery_params
    params.permit(:name, :ba_member, :city, :state, :founded, :annual_production)
  end

end