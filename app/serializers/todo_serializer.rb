class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :completed, :order
  attribute :url do
    "#{$request.headers['HTTP_HOST']}/#{object.id}"
  end
end
