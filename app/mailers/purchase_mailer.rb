class PurchaseMailer < ActionMailer::Base
  default from: 'no-reply@example.com'

  def first_purchase_email(purchase)
    @purchase = purchase
    @product = @purchase.product
    creator = @product.admin
    @customer = @purchase.customer

    admins_emails = Admin.where("id != ?", creator.id).map(&:email).uniq

    mail(
      to: creator.email,
      cc: admins_emails,
      subject: "First Purchase of #{@product.name}"
    )
  end
end
