class BreweriesController < ApplicationController
  def index
    @breweries = case params[:view]
      when 'sort_by_count'
        Brewery.sort_by_count
      when 'search_exact'
        Brewery.search_exact(params[:search_exact])
      when 'search_partial'
        Brewery.search_partial(params[:search_part])
      else
        Brewery.sort_by_created
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

  private

  def brewery_params
    params.permit(:name, :ba_member, :city, :state, :founded, :annual_production)
  end

end