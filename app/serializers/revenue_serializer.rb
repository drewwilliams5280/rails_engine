class RevenueSerializer
  include FastJsonapi::ObjectSerializer
 
  attribute :revenue do |object|
    object.total
  end
end