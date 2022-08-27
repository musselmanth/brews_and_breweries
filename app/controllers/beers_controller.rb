class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:beer_id])
  end

  def edit
    @beer = Beer.find(params[:beer_id])
  end

  def update
    beer = Beer.find(params[:beer_id])
    beer.update(beer_params)
    redirect_to("/beers/#{params[:beer_id]}")
  end

  def beer_params
    params.permit(:name, :style, :abv, :ibu, :in_production)
  end

end