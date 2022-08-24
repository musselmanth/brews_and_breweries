require 'rails_helper'

RSpec.describe 'breweries_beers#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", limited_release: true)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", limited_release: true)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", limited_release: false)
    @sippin_pretty = @odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", limited_release: false)
  end

  it 'lists the beers that below to a particular brewery' do
    visit("/breweries/#{@bells.id}/beers")
    expect(page).to have_content(@bells.name)
    expect(page.has_content?(@odell.name)).to be false

    expect(page).to have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)
    expect(page.has_content?(@ninety_shilling.name)).to be false
    expect(page.has_content?(@sippin_pretty.name)).to be false

    expect(page.has_content?(@oberon.abv)).to be true
    expect(page.has_content?(@ninety_shilling.abv)).to be false
    save_and_open_page
  end
end
