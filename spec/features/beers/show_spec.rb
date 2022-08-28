require 'rails_helper'

RSpec.describe 'beers#show', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: true)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: false)
  end

  it 'lists each child record found in the system' do
    visit("beers/#{@hopslam.id}")

    expect(page).to have_content(@hopslam.name)
    expect(page).to have_content("Bell's Brewery")
    expect(page).to have_content("ABV:")
    expect(page).to have_content("10.0%")
    expect(page).to have_content("IBUs:")
    expect(page).to have_content("65")
    expect(page).to have_content("Currently in Production?:")
    expect(page).to have_content("Yes")
    expect(page).to have_content("Style:")
    expect(page).to have_content("Double IPA")
  end
end
