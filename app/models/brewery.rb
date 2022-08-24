class Brewery < ApplicationRecord
  has_many :beers

  def beer_count
    beers.count
  end
  
end