require 'rails_helper'

describe "Merchants / ID / Items API" do
  it "sends a list of items associated with a specific merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    10.times do 
      create(:item, merchant: merchant_1)
    end
    10.times do 
      create(:item, merchant: merchant_2)
    end

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    response_items = JSON.parse(response.body, symbolize_names: true)
    first_response_item = response_items[:data].first

    expect(first_response_item).to have_key(:id)
    expect(first_response_item[:id]).to be_an(String)
    expect(first_response_item[:attributes]).to have_key(:name)
    expect(first_response_item[:attributes][:name]).to be_a(String)
    expect(first_response_item[:attributes]).to have_key(:merchant_id)
    expect(first_response_item[:attributes][:merchant_id]).to be_a(Integer)
    expect(first_response_item[:attributes]).to have_key(:unit_price)
    expect(first_response_item[:attributes][:unit_price]).to be_a(Float)
   
    response_items[:data].each do |item|
      expect(item[:attributes][:merchant_id]).to eq(merchant_1.id)
    end
  end
end