require 'rails_helper'

RSpec.describe Brewery, type: :model do
  it {should have_many :beers}
end