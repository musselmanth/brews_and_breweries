require 'rails_helper'

RSpec.describe 'breweries#delete', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
  end

  it 'can delete a brewery from the show page' do
    visit("/breweries")
    expect(page).to have_content(@bells.name)
    expect(page).to have_content(@odell.name)

    visit("breweries/#{@bells.id}")
    expect(page).to have_button("Delete #{@bells.name}")

    click_button("Delete #{@bells.name}")

    expect(current_path).to eq("/breweries")
    expect(page).to_not have_content(@bells.name)
    expect(page).to have_content(@odell.name)

    visit("/breweries/#{@odell.id}")
    expect(page).to have_button("Delete #{@odell.name}")

    click_button("Delete #{@odell.name}")

    expect(current_path).to eq("/breweries")
    expect(page).to_not have_content(@bells.name)
    expect(page).to_not have_content(@odell.name)
  end

  it 'can delete breweries even when they have beers' do
    two_hearted = @bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", in_production: true)
    oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
    ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: true)

    visit("/breweries")
    expect(page).to have_content(@bells.name)
    visit("/beers")
    expect(page).to have_content(two_hearted.name)
    expect(page).to have_content(oberon.name)
    expect(page).to have_content(ninety_shilling.name)

    visit("/breweries/#{@bells.id}")
    click_button("Delete #{@bells.name}")

    expect(current_path).to eq("/breweries")
    expect(page).to_not have_content(@bells.name)

    visit("/beers")
    expect(page).to_not have_content(two_hearted.name)
    expect(page).to_not have_content(oberon.name)
    expect(page).to have_content(ninety_shilling.name)
  end
    
end
