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
    expect(@crooked_stave.name).to appear_before(@bells.name)
    expect(@bells.name).to appear_before(@odell.name)
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

  describe 'sort breweries by number of beers' do

    before(:each) do
      @bells.beers.create(name: "Two Hearted Ale", abv: 7.0, ibu: 55, style:"IPA", in_production: true)
      @bells.beers.create(name: "Hopslam", abv:10.0 , ibu:65 , style:"Double IPA", in_production: false)
      @bells.beers.create(name: "Oberon", abv: 5.8, ibu: 10, style:"Wheat", in_production: true)
      @odell.beers.create(name: "Isolation Ale", abv: 6.1, ibu: 27, style: "Winter Warmer", in_production: false)
      @odell.beers.create(name: "Easy Street", abv: 4.6, ibu: 21, style: "American Pale Wheat", in_production: true)
      @crooked_stave.beers.create(name: "Sour Rosé", abv: 4.5, ibu: 0, style:"Wild Ale", in_production: true)
    end

    it 'has a link to sort by number of beers' do
      visit("/breweries")

      expect(@crooked_stave.name).to appear_before(@bells.name)
      expect(@bells.name).to appear_before(@odell.name)

      click_link("Sort By Number of Beers on Record")
      
      expect(@bells.name).to appear_before(@odell.name)    
      expect(@odell.name).to appear_before(@crooked_stave.name)
    end
    
    it 'lists the number of beers on record once the button is clicked' do
      visit("/breweries")
      
      expect(page).to_not have_content("3 beers on record.")
      expect(page).to_not have_content("2 beers on record.")
      expect(page).to_not have_content("1 beers on record.")
      
      click_link("Sort By Number of Beers on Record")

      expect(page).to have_content("3 beers on record.")
      expect(page).to have_content("2 beers on record.")
      expect(page).to have_content("1 beers on record.")
    end

  end

  describe 'search features' do
    before(:each) do
      @bells_other = Brewery.create(name: "Bell's Other Brewery", city:"Comstock", state:"MI", ba_member: true, annual_production: 310000, founded: 1985)
      @crooked_stave = Brewery.create(name: "Crooked Stave", city:"Denver", state:"CO", ba_member: false, annual_production: 60000, founded: 2010)
    end

    it 'can find exact search results' do
      visit("/breweries")
      fill_in("Search Exact", with: "Bell's Brewery")
      within("form#exact_search_form") do
        click_button("Search")
      end

      expect(page).to have_content("Bell's Brewery")
      expect(page).to_not have_content("Bell's Other Brewery")
      expect(page).to_not have_content("Crooked Stave")
    end

    it 'can find partial search results' do
      visit("/breweries")
      fill_in("Search Partial", with: "Bell's")
      within("form#partial_search_form") do
        click_button("Search")
      end

      expect(page).to have_content("Bell's Brewery")
      expect(page).to have_content("Bell's Other Brewery")
      expect(page).to_not have_content("Crooked Stave")
      expect(page).to_not have_content("Odell")
    end

  end

end