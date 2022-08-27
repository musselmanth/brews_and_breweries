# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.

require 'rails_helper'

RSpec.describe 'Create a new Brewery' do

  describe 'new link on brewery index' do

    it 'links to brewery/new' do
      visit "/breweries"

      expect(page).to have_content("Input New Brewery")
      
      click_on("Input New Brewery")

      expect(current_path).to eq("/breweries/new")
    end

    it 'has a form that can create a new artist' do
      visit("/breweries/new")
      expect(page).to have_content("Add New Brewery")

      fill_in("Name", with: "Founders Brewing Company")
      check("Brewer's Association Member")

      fill_in("City", with: "Grand Rapids")
      fill_in("State", with: "MI")
      fill_in("Year Founded", with: "1997")
      fill_in("Annual Production", with: "115000")

      click_button("Add Brewery")

      expect(current_path).to eq("/breweries")

      expect(page).to have_content("Founders Brewing Company")
    end


  end

end