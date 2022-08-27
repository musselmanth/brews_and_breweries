class BreweryBeersController < ApplicationController
  def index
    @brewery = Brewery.find(params[:brewery_id])
    @beers = @brewery.beers
  end

  def new
    @brewery = Brewery.find(params[:brewery_id])
  end

  def create
    Beer.create(beer_params)
    redirect_to("/breweries/#{params[:brewery_id]}/beers")
  end

  def beer_params
    params.permit(:name, :brewery_id, :style, :abv, :ibu, :in_production)
  end
end