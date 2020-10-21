class Api::V1::Items::SearchController < ApplicationController
  
  def index
    items = Item.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%")
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%").first
    render json: ItemSerializer.new(item)
  end

end