class Brewery < ApplicationRecord
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

  def self.search_exact(search_phrase)
    self.where(name: search_phrase)
  end

  def self.search_partial(search_phrase)
    self.where("name ILIKE ?", "%#{sanitize_sql_like(search_phrase)}%")
  end
  
end