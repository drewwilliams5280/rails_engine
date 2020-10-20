class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :merchant_id

  attribute :unit_price do |object|
    object.convert_unit_price
  end
end
