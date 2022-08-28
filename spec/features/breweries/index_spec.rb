require 'rails_helper'

RSpec.describe 'breweries#index', type: :feature do
  before(:each) do
    @crooked_stave = Brewery.create(name: "Crooked Stave", city:"Denver", state:"CO", ba_member: false, annual_production: 60000, founded: 2010)
    @bells = Brewery.create(name: "Bell's Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
    @odell = Brewery.create(name: "Odell Brewing Company", city:"Fort Collins", state:"CO", ba_member: true, annual_production: 225000, founded: 1989)
  end

  it 'lists each parent record found in the system' do
    visit('/breweries')
    expect(page).to have_content(@bells.name)
    expect(page).to have_content(@odell.name)
  end

  # As a visitor
  # When I visit the parent index,
  # I see that records are ordered by most recently created first
  # And next to each of the records I see when it was created

  it 'lists the parent index in the order they were created' do
    visit('/breweries')
    expect("#{@crooked_stave.name}").to appear_before("#{@bells.name}")
    expect("#{@crooked_stave.name}").to appear_before("#{@odell.name}")
    expect("#{@bells.name}").to appear_before("#{@odell.name}")
  end

  it 'shows on the page when it was created.' do
    visit("/breweries")

    expect(page).to have_content(@crooked_stave.created_at)
    expect(page).to have_content(@bells.created_at)
    expect(page).to have_content(@odell.created_at)
  end

  it 'has links to edit the breweries' do
    visit("/breweries")

    expect(page).to have_content("Edit")

    within("table##{@bells.id}") do
      click_link("Edit")
      expect(current_path).to eq("/breweries/#{@bells.id}/edit")
    end

    visit("/breweries")

    within("table##{@odell.id}") do
      click_link("Edit")
      expect(current_path).to eq("/breweries/#{@odell.id}/edit")
    end
  end

  it 'has links to delete breweries' do
    visit("/breweries")

    expect(page).to have_content("Delete")
    expect(page).to have_content(@bells.name)
    expect(page).to have_content(@crooked_stave.name)

    within("table##{@bells.id}") do
      click_link("Delete")
      expect(current_path).to eq("/breweries")
    end
    
    expect(page).to_not have_content(@bells.name)
    expect(page).to have_content(@crooked_stave.name)
  end

end