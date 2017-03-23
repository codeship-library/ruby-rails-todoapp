class Todo < ApplicationRecord
  alias_attribute :order, :position
  validates_presence_of :title
end
