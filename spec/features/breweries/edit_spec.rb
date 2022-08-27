# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/parents/:id',
# the parent's info is updated,
# and I am redirected to the Parent's Show page where I see the parent's updated info

require 'rails_helper'

RSpec.describe 'Edit existing Brewery' do

  before(:each) do
    @bells = Brewery.create!(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
  end

  describe 'edit link on brewery show page' do

    it 'links to brewery/new' do
      visit "/breweries/#{@bells.id}"

      expect(page).to have_button("Edit #{@bells.name} Info")
      
      click_button("Edit #{@bells.name} Info")

      expect(current_path).to eq("/breweries/#{@bells.id}/edit")
    end

    it 'has a form that can edit existing brewery' do
      visit("/breweries/#{@bells.id}/edit")
      expect(page).to have_content("Edit #{@bells.name} Information")

      uncheck("BA Member")

      fill_in("City", with: "Kalamazoo")

      click_button("Update #{@bells.name}")

      expect(current_path).to eq("/breweries/#{@bells.id}")

      expect(page).to have_content("Brewer's Association Member: No")
      expect(page).to have_content("Location: Kalamazoo, MI")
    end

  end

end