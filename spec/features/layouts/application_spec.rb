require 'rails_helper'

RSpec.describe 'Application' do
  context 'view all parents link' do

    before :each do
      @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
      @two_hearted = @bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", in_production: false)
    end

    it 'has link to parents and children index on every page' do

      visit("/breweries")
      expect(page).to have_content "View All Breweries"
      expect(page).to have_content "View All Beers"
      click_link("View All Beers")
      expect(current_path).to eq("/beers")

      visit("/breweries/#{@bells.id}")
      expect(page).to have_content "View All Breweries"
      expect(page).to have_content "View All Beers"
      click_link("View All Breweries")
      expect(current_path).to eq("/breweries")

      visit("/beers")
      expect(page).to have_content "View All Breweries"
      expect(page).to have_content "View All Beers"
      click_link("View All Breweries")
      expect(current_path).to eq("/breweries")

      visit("/beers/#{@two_hearted.id}")
      expect(page).to have_content "View All Breweries"
      expect(page).to have_content "View All Beers"
      click_link("View All Beers")
      expect(current_path).to eq("/beers")

    end
  end
end