require 'rails_helper'

RSpec.describe Beer, type: :model do

  it {should belong_to :brewery}

  describe 'class methods' do

    before(:each) do 
      @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
      @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
  
      @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: true)
      @drumroll = @odell.beers.create(name: "Drumroll", abv: 5.3, ibu: 42, style:"Pale Ale", in_production: true)
      @sippin_pretty = @odell.beers.create(name: "Sippin Pretty", abv: 4.5, ibu: 0, style:"Fruited Sour", in_production: true)
      @expedition = @bells.beers.create(name: "Expedition Stout", abv: 10.5, ibu: 0, style: "Russian Imperial Stout", in_production: true)
      @best_brown = @bells.beers.create(name: "Best Brown Ale", abv: 5.8, ibu: 34, style: "American Brown Ale", in_production: true)

    end

    describe '#in_production' do
      it 'only returns results with true boolean' do
        not_in_production = @bells.beers.create(name: "Not In Prod Beer", abv: 3.2, ibu: 23, style: "Unknown", in_production: false)
        expect(Beer.in_production).to include(@ninety_shilling, @drumroll, @sippin_pretty, @expedition, @best_brown)
        expect(Beer.in_production).to_not include(not_in_production)
      end
    end

    describe 'sort by name' do
      it 'can sort all beers by name' do
        expect(Beer.sort_by_name).to eq([@ninety_shilling, @best_brown, @drumroll, @expedition, @sippin_pretty])
      end

      it 'can sort a subset of beers by name' do
        expect(@bells.beers.sort_by_name).to eq([@best_brown, @expedition])
        expect(@odell.beers.sort_by_name).to eq([@ninety_shilling, @drumroll, @sippin_pretty])
        expect(Beer.where("abv > 5.4").sort_by_name).to eq([@best_brown, @expedition])
      end
    end



    describe 'search features' do

      before(:each) do
        @different_brown = @bells.beers.create(name: "Different Brown Ale", abv: 5.8, ibu: 34, style: "American Brown Ale", in_production: true)
        @different_expedition = @odell.beers.create(name: "Expedition Stout", abv: 5.5, ibu: 15, style: "Stout", in_production: true)
      end

      it 'can return exact search results' do
        expect(Beer.search_exact("Best Brown Ale")).to eq([@best_brown])
        expect(Beer.search_exact("Expedition Stout")).to eq([@expedition, @different_expedition])
        expect(Beer.search_exact("Different Brown Ale")).to eq([@different_brown])
      end

      it 'can return parial search results' do
        expect(Beer.search_partial("Brown Ale")).to eq([@best_brown, @different_brown])
        expect(Beer.search_partial("Expedition")).to eq([@expedition, @different_expedition])
      end

    end

  end



end