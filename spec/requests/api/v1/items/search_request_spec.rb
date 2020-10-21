require 'rails_helper'

describe "Item search" do
  it "can get list of items with a search term" do
    create(:item, name: "Scooby Doo")
    create(:item, name: "Drewby Doo")
    create(:item, name: "Howdydoody")
    create(:item, name: "Boboblob")
    create(:item, name: "Hello World")

    get '/api/v1/items/find_all?name=DOO'
    
    expect(response).to be_successful

    items_with_doo = JSON.parse(response.body, symbolize_names: true)
    expect(items_with_doo).to be_a Hash

    search_results = items_with_doo[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(3)
    expect(search_results[0][:attributes][:name].downcase.include?("doo")).to eq(true)
    expect(search_results[1][:attributes][:name].downcase.include?("doo")).to eq(true)
    expect(search_results[2][:attributes][:name].downcase.include?("doo")).to eq(true)
  end

  it "can get a Item with a search term" do
    create(:item, name: "Scooby Doo")
    create(:item, name: "Drewby Doo")
    create(:item, name: "Howdydoody")
    create(:item, name: "Boboblob")
    create(:item, name: "Hello World")
    get '/api/v1/items/find?name=DOO'
    
    expect(response).to be_successful

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json).to be_a Hash

    item = item_json[:data]
    expect(item).to be_a Hash
    expect(item[:attributes][:name].downcase.include?("doo")).to eq(true)
  end
end