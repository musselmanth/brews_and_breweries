class BreweryBeersController < ApplicationController
  def index
    sort_by = params[:sort_by]
    @min_abv = params[:min_abv]
    @min_abv ||= 0.0
    @brewery = Brewery.find(params[:brewery_id])
    @beers = @brewery.beers.where("abv >= #{@min_abv}").order(params[:sort_by])
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