class Beer < ApplicationRecord
  belongs_to :brewery

  def self.sort_by_name
    self.order(:name)
  end
end