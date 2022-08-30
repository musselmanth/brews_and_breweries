class BreweriesController < ApplicationController
  def index
    @breweries = case params[:sort_by_count]
      when 'true'
        Brewery.sort_by_count
      else
        Brewery.all
    end
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

  def destroy
    Brewery.destroy(params[:brewery_id])
    redirect_to("/breweries")
  end

  def brewery_params
    params.permit(:name, :ba_member, :city, :state, :founded, :annual_production)
  end

end