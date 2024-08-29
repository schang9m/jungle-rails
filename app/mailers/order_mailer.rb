class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_confirmation(order)
    @user = User.find_by(email: order.email) # Find the user by email stored in the order
    if @user
      mail(to: @user.email, subject: 'Your Order Confirmation')
    else
      Rails.logger.error("No user found with email #{order.email} for Order ##{order.id}")
      # Optionally handle cases where user is missing
    end
  end
end
