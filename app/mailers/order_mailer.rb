class OrderMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def order_confirmation(order)
    @order = order
    @user = @order.user
    mail(to: @user.email, subject: 'Your Order Confirmation')
  end
end
