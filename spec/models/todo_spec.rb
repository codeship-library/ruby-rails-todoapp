require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Todo, type: :model do
  it { should validate_presence_of(:title) }
end
