class Api::V1::MerchantsController < ApplicationController
  def index
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end