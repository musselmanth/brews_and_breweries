require_relative 'searchable'

class Beer < ApplicationRecord
  extend Searchable

  belongs_to :brewery

  def self.sort_by_name
    self.order(:name)
  end

  def self.in_production
    self.where(in_production: true)
  end
end