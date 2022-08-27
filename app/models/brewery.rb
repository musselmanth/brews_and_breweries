class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy

  def beer_count
    beers.count
  end
  
end