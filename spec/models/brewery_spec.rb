require 'rails_helper'

RSpec.describe Brewery, type: :model do
  it {should have_many :beers}

  before(:each) do
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)

    @two_hearted = @bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", in_production: false)
    @oberon = @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
    @hopslam = @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: true)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: false)
  end

  it 'can tell how many beers it has' do
    expect(@bells.beer_count).to eq(3)
    expect(@odell.beer_count).to eq(1)
  end

  it 'can return beers above an abv threshold for a given brewery' do
    expect(@bells.beers_filtered_by_abv(6.0)).to eq([@two_hearted, @hopslam])
    expect(@bells.beers_filtered_by_abv(8.0)).to eq([@hopslam])
  end
end