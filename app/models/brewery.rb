class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy

  def beer_count
    self.beers.count
  end

  def beers_filtered_by_abv(min_abv)
    self.beers.where("abv >= #{min_abv}")
  end
  
end