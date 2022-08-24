require 'rails_helper'

RSpec.describe Beer, type: :model do
  it {should belong_to :brewery}
end