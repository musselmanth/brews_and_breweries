# As a visitor
# When I visit a Parent Children Index page
# Then I see a link to add a new adoptable child for that parent "Create Child"
# When I click the link
# I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
# When I fill in the form with the child's attributes:
# And I click the button "Create Child"
# Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
# a new child object/row is created for that parent,
# and I am redirected to the Parent Childs Index page where I can see the new child listed

require 'rails_helper'

RSpec.describe 'Create a new beer' do

  before(:each) do
    @stone = Brewery.create(name: "Stone Brewing", city:"Escondido", state:"CA", ba_member: true, annual_production: 325000, founded: 1996)
  end

  describe "new link on brewery's beers index" do

    it 'links to breweries/id/beers/new' do
      visit "/breweries/#{@stone.id}/beers"

      expect(page).to have_button("Add New Beer")
      
      click_on("Add New Beer")

      expect(current_path).to eq("/breweries/#{@stone.id}/beers/new")
    end

  end

  describe 'can add new beer' do

    it 'has a form that can create a new beer' do
      visit("/breweries/#{@stone.id}/beers/new")
      expect(page).to have_content("Add New Beer for #{@stone.name}")

      fill_in("Name", with: "Dayfall")
      fill_in("Style", with: "Belgian White")
      fill_in("ABV", with: "5.5")
      fill_in("IBU", with: "13")
      check("Currently In Production")

      click_button("Add Beer")

      expect(current_path).to eq("/breweries/#{@stone.id}/beers")

      expect(page).to have_content("Dayfall")
    end

  end

end