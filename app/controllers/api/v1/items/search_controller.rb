class Api::V1::Items::SearchController < ApplicationController
  
  def index
    method = request.env["PATH_INFO"].split('/').last.downcase
    items = Item.send(method, params)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%").first
    render json: ItemSerializer.new(item)
  end

end