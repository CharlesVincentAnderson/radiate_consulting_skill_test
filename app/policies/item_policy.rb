# controls who can access item controller actions
class ItemPolicy < ApplicationPolicy
  def logged_in_and_owner?
    @user.present? && @user.items.include?(@record)
  end

  def logged_in?
    @user.present?
  end

  %i(new? create? my_items? select_item?).each do |ali|
    alias_method ali, :logged_in?
  end

  %i(edit? update? destroy? inc_quantity? dec_quantity? remove_item?).each do |ali|
    alias_method ali, :logged_in_and_owner?
  end
end

