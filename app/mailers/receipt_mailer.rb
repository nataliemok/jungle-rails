class ReceiptMailer < ApplicationMailer
#  default from: 'notifications@example.com'
  def receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Your order receipt for #{@order.id}")
  end
end
