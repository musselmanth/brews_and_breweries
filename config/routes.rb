Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/breweries', to: 'breweries#index'
  get '/breweries/:brewery_id', to: 'breweries#show'

  get '/beers', to: 'beers#index'
  get '/beers/:beer_id', to: 'beers#show'
end
