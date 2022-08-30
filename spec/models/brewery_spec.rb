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

  describe 'class methods' do
    it 'can return the breweries sorted by beer count' do
      expect(Brewery.sort_by_count).to eq([@bells, @odell])
      
      @odell.beers.create(name: "St. Lupulin", abv: 6.5, ibu: 46, style: "Pale Ale", in_production: true)
      @odell.beers.create(name: "Isolation Ale", abv: 6.1, ibu: 27, style: "Winter Warmer", in_production: true)
      @odell.beers.create(name: "Easy Street", abv: 4.6, ibu: 21, style: "American Pale Wheat", in_production: true)
      
      expect(Brewery.sort_by_count).to eq([@odell, @bells])
    end
    describe 'search' do
      before(:each) do
        @bells_other = Brewery.create(name: "Bell's Other Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
        @crooked_stave = Brewery.create(name: "Crooked Stave", city:"Denver", state:"CO", ba_member: false, annual_production: 60000, founded: 2010)
      end
      
      it 'can return a list of breweries that match a name search' do
        expect(Brewery.search_exact("Bell's Brewery")).to eq([@bells])
        expect(Brewery.search_exact("Bell's")).to eq([])
        expect(Brewery.search_exact("Crooked Stave")).to eq([@crooked_stave])
      end

      it 'can return a list of breweries that contain a search parameter' do
        expect(Brewery.search_partial("Bell's")).to eq([@bells, @bells_other])
        expect(Brewery.search_partial("Brew")).to eq([@bells, @bells_other, @odell])
        expect(Brewery.search_partial("Crooked")).to eq([@crooked_stave])
      end
    end
  end


end