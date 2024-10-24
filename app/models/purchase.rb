class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  validates :quantity, numericality: { greater_than: 0 }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  after_create :send_first_purchase_email, if: :first_purchase?

  def send_first_purchase_email
    PurchaseMailer.first_purchase_email(self).deliver
  end

  private

  def first_purchase?
    Purchase.where(product_id: product_id).count == 1
  end
end
