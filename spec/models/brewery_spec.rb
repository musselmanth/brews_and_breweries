require 'rails_helper'

RSpec.describe Brewery, type: :model do
  it {should have_many :beers}

  it 'can tell how many beers it has' do
    bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", limited_release: false)
    bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", limited_release: true)
    bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", limited_release: true)

    expect(bells.beer_count).to eq(3)
  end
end