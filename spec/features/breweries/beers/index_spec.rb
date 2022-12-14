require 'rails_helper'

RSpec.describe 'breweries_beers#index', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: true)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: false)
    @sippin_pretty = @odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", in_production: false)
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
    
  end

  it 'has a link to sort them by name' do
    visit("/breweries/#{@bells.id}/beers")

    expect(page).to have_link("Sort By Name")
    expect("#{@oberon.name}").to appear_before("#{@hopslam.name}")

    click_link("Sort By Name")

    expect("#{@hopslam.name}").to appear_before("#{@oberon.name}")
  end

  it 'has a link to edit each beer' do
    visit("/breweries/#{@bells.id}/beers")
    expect(page).to have_link("Edit")

    within("table##{@oberon.id}") do
      click_link("Edit")
      expect(current_path).to eq("/beers/#{@oberon.id}/edit")
    end

    visit("/breweries/#{@bells.id}/beers")
    within("table##{@hopslam.id}") do
      click_link("Edit")
      expect(current_path).to eq("/beers/#{@hopslam.id}/edit")
    end
  end

  it 'has a link to delete a beer' do
    visit("/breweries/#{@bells.id}/beers")
    expect(page).to have_link("Delete")

    within("table##{@oberon.id}") do
      click_link("Delete")
    end
    expect(current_path).to eq("/beers")
    expect(page).to_not have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)

  end

  it 'has a form to filter by a min abv' do
    visit("/breweries/#{@bells.id}/beers")

    expect(page).to have_content("Only Show Beers with ABV Greater Than:")
    expect(page).to have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)

    fill_in(:min_abv, with: "7.0")
    click_button("Submit")
    
    expect(page).to_not have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)
  end

end
