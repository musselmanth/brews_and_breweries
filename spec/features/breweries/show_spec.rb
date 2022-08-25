require 'rails_helper'

RSpec.describe 'breweries#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", limited_release: false)
    @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", limited_release: true)
    @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", limited_release: true)
    @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", limited_release: false)
    @odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", limited_release: false)
  end

  it 'shows information about a particular brewery' do
    visit("/breweries/#{@bells.id}")
  
    expect(page).to have_content(@bells.name)
    expect(page).to have_content("Founded: 1985")
    expect(page).to have_content("Annual Production: 310,000 beer barrels")
    expect(page).to have_content("Brewer's Association Member: Yes")
    expect(page).to have_content("Location: Comstock, MI")
  end

  it 'shows the number of beers for each brewery.' do
    visit("/breweries/#{@bells.id}")

    expect(page).to have_content("Number of beers on record: #{@bells.beer_count}")

    visit("/breweries/#{@odell.id}")

    expect(page).to have_content("Number of beers on record: #{@odell.beer_count}")
  end

  it 'has a link to show the children for the particular parent' do
    visit("/breweries/#{@bells.id}")
    expect(page).to have_content("View #{@bells.name} Beers")
    click_link("View #{@bells.name} Beers")
    expect(current_path).to eq("/breweries/#{@bells.id}/beers")
  end

end