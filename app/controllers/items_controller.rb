class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new item_params
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path, notice: "item created"
    else
      redirect_to root_path, notice: "item could not be created"
    end
  end

  def edit
    @item = item.new
  end

  def update
    if @item.update item_params
      redirect_to root_path, notice: "item updated"
    else
      redirect_to root_path, notice: "item could not be updated"
    end
  end

  def show

  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "item destroyed"
    else
      redirect_to root_path, notice: "item could not be destroyed"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity)
  end

  def set_item
    @item = Item.find params[:id]
  end
end
