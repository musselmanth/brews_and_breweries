require 'rails_helper'

RSpec.describe 'breweries#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
  end

  it 'shows information about a particular brewery' do
    visit("/breweries/#{@bells.id}")
  
    expect(page).to have_content(@bells.name)
    expect(page).to have_content("Founded: 1985")
    expect(page).to have_content("Annual Production: 310,000 beer barrels")
    expect(page).to have_content("Brewer's Association Member: Yes")
    expect(page).to have_content("Location: Comstock, MI")
  end

end