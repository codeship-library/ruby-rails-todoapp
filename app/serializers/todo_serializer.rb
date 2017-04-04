class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :completed, :order
  attribute :url do
    "#{$request.protocol}#{$request.headers['HTTP_HOST']}/todos/#{object.id}"
  end
end
