class Api::V1::RevenueController < ApplicationController

  def index
    request_revenue = Merchant.total_revenue_between_dates(params)
    revenue = Amount.new(request_revenue)
    render json: RevenueSerializer.new(revenue)
  end

end