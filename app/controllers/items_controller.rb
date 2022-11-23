class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create 
    puts "these are params", params
    user = User.find(params[:user_id])
    new_item = user.items.create(items_params)
    render json: new_item, status: :created
  end

  private

  def render_not_found_response
    render json: { errors: "Not Found" }, status: :not_found
  end

  def items_params
    params.permit(:name, :description, :price, :user_id)
  end
end
