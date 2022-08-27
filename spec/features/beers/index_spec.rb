require 'rails_helper'

RSpec.describe 'beers#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: true)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: true)
    @sippin_pretty = @odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", in_production: false)
  end

  it 'lists each child record found in the system with boolean true' do
    visit('/beers')

    expect(page).to have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)
    expect(page).to have_content(@ninety_shilling.name)
    expect(page).to_not have_content(@sippin_pretty.name)
  end

  it 'has a link to edit each beer' do
    visit("/beers")
    expect(page).to have_link("Edit")

    within("table##{@oberon.id}") do
      click_link("Edit")
      expect(current_path).to eq("/beers/#{@oberon.id}/edit")
    end
  end

  it 'each edit link goes to the right beer' do
    visit("/beers")
    within("table##{@ninety_shilling.id}") do
      click_link("Edit")
      expect(current_path).to eq("/beers/#{@ninety_shilling.id}/edit")
    end
  end
end
