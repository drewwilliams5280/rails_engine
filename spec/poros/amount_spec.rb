require 'rails_helper'

describe Amount do
  describe "it exists" do
    it "has initialized methods" do
      revenue = Amount.new(1000)
      expect(revenue).to be_a Amount 
      expect(revenue.id).to eq(nil)
      expect(revenue.total).to eq(1000)
    end
  end
end