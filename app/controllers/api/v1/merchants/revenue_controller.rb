class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    request_revenue = Merchant.total_revenue_for_merchant(merchant.id)
    revenue = Amount.new(request_revenue)
    render json: RevenueSerializer.new(revenue)
  end

end