require 'rails_helper'

RSpec.describe 'breweries#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
  end

  it 'lists each parent record found in the system' do
    visit('/breweries')
    expect(page).to have_content(@bells.name)
    expect(page).to have_content(@odell.name)
  end
end