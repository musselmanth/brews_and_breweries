require_relative 'searchable'

class Brewery < ApplicationRecord
  extend Searchable

  has_many :beers, dependent: :destroy

  def beer_count
    self.beers.count
  end

  def beers_filtered_by_abv(min_abv)
    self.beers.where("abv >= #{min_abv}")
  end

  def self.sort_by_count
    self.all.sort_by(&:beer_count).reverse
  end

  def self.sort_by_created
    self.order(created_at: :desc)
  end
  
end