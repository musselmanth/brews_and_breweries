require 'rails_helper'

RSpec.describe 'beers#delete', type: :feature do
  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: true)
  end

  it 'can delete a brewery from the show page' do
    visit("/beers")
    expect(page).to have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)

    visit("beers/#{@oberon.id}")
    expect(page).to have_button("Delete #{@oberon.name}")

    click_button("Delete #{@oberon.name}")

    expect(current_path).to eq("/beers")
    expect(page).to_not have_content(@oberon.name)
    expect(page).to have_content(@hopslam.name)
  end
    
end
