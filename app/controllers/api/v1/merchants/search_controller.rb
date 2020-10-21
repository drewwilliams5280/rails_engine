class Api::V1::Merchants::SearchController < ApplicationController
  def index
    method = request.env["PATH_INFO"].split('/').last.downcase
    merchants = Merchant.send(method, params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%").first
    render json: MerchantSerializer.new(merchant)
  end
end