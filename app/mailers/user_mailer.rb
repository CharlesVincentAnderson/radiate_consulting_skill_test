class UserMailer < ApplicationMailer
  default from: 'charlesvincentanderson.com'

  def inventory_email
    @user = params[:user]
    @item = params[:item]
    @url  = 'http://radiate-consulting-skill-test.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'One of your inventories hit a quantity of 0!')
  end

end
