class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy, :inc_quantity, :dec_quantity]

  def index
    @items = Item.all
  end

  def my_items
    if current_user.present?
      @items = current_user.items
    else
      @items = Item.all
    end
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

  def inc_quantity
    @item.quantity = @item.quantity + 1
    @item.save
    redirect_to my_items_items_path
  end

  def dec_quantity
    @item.quantity = @item.quantity - 1
    @item.save
    redirect_to my_items_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :quantity)
  end

  def set_item
    @item = Item.find params[:id]
  end
end