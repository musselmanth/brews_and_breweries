class BeersController < ApplicationController
  def index
    @beers = case params[:view]
      when 'search_exact'
        Beer.in_production.search_exact(params[:search_exact])
      when 'search_partial'
        Beer.in_production.search_partial(params[:search_part])
      else
        Beer.in_production
    end
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

  def destroy
    Beer.destroy(params[:beer_id])
    redirect_to("/beers")
  end

  private

  def beer_params
    params.permit(:name, :style, :abv, :ibu, :in_production)
  end

end