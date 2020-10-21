class Api::V1::Merchants::SearchController < ApplicationController
  
  def index
    merchants = Merchant.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%")
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%").first
    render json: MerchantSerializer.new(merchant)
  end

end