# As a visitor
# When I visit a Child Show page
# Then I see a link to update that Child "Update Child"
# When I click the link
# I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
# When I click the button to submit the form "Update Child"
# Then a `PATCH` request is sent to '/child_table_name/:id',
# the child's data is updated,
# and I am redirected to the Child Show page where I see the Child's updated information

require 'rails_helper'

RSpec.describe 'Update Beers' do
  before(:each) do
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
    @ninety_shilling = @odell.beers.create(name: "90 Shilling", abv: 5.3, ibu: 27, style:"Red Ale", in_production: true)
  end

  it 'has a link to update a beer on the beers show page' do
    visit("/beers/#{@ninety_shilling.id}")
    
    expect(page).to have_button("Edit #{@ninety_shilling.name} Info")

    click_button("Edit #{@ninety_shilling.name} Info")

    expect(current_path).to eq("/beers/#{@ninety_shilling.id}/edit")
  end

  it 'can update a beer' do
    visit("/beers/#{@ninety_shilling.id}/edit")

    expect(page).to have_content("Edit #{@ninety_shilling.name} Information")

    uncheck(:in_production)

    fill_in("Style", with: "Stout")

    click_button("Update Beer")

    expect(current_path).to eq("/beers/#{@ninety_shilling.id}")
    expect(page).to have_content("Currently in Production?:")
    expect(page).to have_content("No")
    expect(page).to have_content("Style:")
    expect(page).to have_content("Stout")

  end

end