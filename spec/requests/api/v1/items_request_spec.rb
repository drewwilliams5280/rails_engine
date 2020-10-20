require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)
    get '/api/v1/items'
    
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it "get specific item details" do
    create(:item)
    item = Item.first
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
      
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(3)
  
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  end

  it "can create a new item" do
    merchant = create(:merchant)

    name = "Shiny Itemy Item"
    description = "It does a lot of things real good"
    unit_price = 5011.96
    merchant_id = merchant.id

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
      }
    headers = {"CONTENT_TYPE" => "application/json"}
    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post "/api/v1/items", headers: headers, params: JSON.generate(body)
    item = Item.last
    expect(response).to be_successful
    expect(item.name).to eq(body[:name])
    expect(item.description).to eq(body[:description])
    expect(item.unit_price).to eq(body[:unit_price])
    expect(item.merchant_id).to eq(body[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Sledge" }
    headers = {"CONTENT_TYPE" => "application/json"}
    put "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Sledge")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end