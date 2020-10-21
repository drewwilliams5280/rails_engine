require 'rails_helper'

describe "Merchant search" do
  it "can get list of merchants with a search term" do
    create(:merchant, name: "Scooby Doo")
    create(:merchant, name: "Drewby Doo")
    create(:merchant, name: "Howdydoody")
    create(:merchant, name: "Boboblob")
    create(:merchant, name: "Hello World")

    get '/api/v1/merchants/find_all?name=DOO'
    
    expect(response).to be_successful

    merchants_with_doo = JSON.parse(response.body, symbolize_names: true)
    expect(merchants_with_doo).to be_a Hash

    search_results = merchants_with_doo[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(3)
    expect(search_results[0][:attributes][:name].downcase.include?("doo")).to eq(true)
    expect(search_results[1][:attributes][:name].downcase.include?("doo")).to eq(true)
    expect(search_results[2][:attributes][:name].downcase.include?("doo")).to eq(true)
  end

  it "can get a merchant with a search term" do
    create(:merchant, name: "Scooby Doo")
    create(:merchant, name: "Drewby Doo")
    create(:merchant, name: "Howdydoody")
    create(:merchant, name: "Boboblob")
    create(:merchant, name: "Hello World")

    get '/api/v1/merchants/find?name=DOO'
    
    expect(response).to be_successful

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json).to be_a Hash

    merchant = merchant_json[:data]
    expect(merchant).to be_a Hash
    expect(merchant[:attributes][:name].downcase.include?("doo")).to eq(true)
  end
end