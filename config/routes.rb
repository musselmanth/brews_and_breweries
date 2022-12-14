Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  get '/breweries/:brewery_id', to: 'breweries#show'
  get '/breweries/:brewery_id/edit', to: 'breweries#edit'
  get '/breweries/:brewery_id/beers', to: 'brewery_beers#index'

  post '/breweries', to: 'breweries#create'
  patch '/breweries/:brewery_id', to: 'breweries#update'
  delete '/breweries/:brewery_id', to: 'breweries#destroy'

  get '/beers', to: 'beers#index'
  get '/beers/:beer_id', to: 'beers#show'
  get '/beers/:beer_id/edit', to: 'beers#edit'
  
  patch '/beers/:beer_id', to: 'beers#update'
  delete '/beers/:beer_id', to: 'beers#destroy'

  get '/breweries/:brewery_id/beers/new', to: 'brewery_beers#new'
  post '/breweries/:brewery_id/beers', to: 'brewery_beers#create'

end
