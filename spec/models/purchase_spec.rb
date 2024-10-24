require 'spec_helper'

describe Purchase do
  let!(:admin) { Admin.create!(name: 'Alice Johnson', email: 'alice@example.com') }
  let(:product) { Product.create!(name: 'SmartLight', description: 'Test product', price: 399.99, admin: admin) }
  let(:customer) { Customer.create!(name: 'John Doe', email: 'john@example.com') }

  before do
    ActionMailer::Base.deliveries.clear
  end

  it 'sends an email for the first purchase of a product' do
    purchase = Purchase.create!(product: product, customer: customer, quantity: 1, total_price: 399.99)
    purchase.send_first_purchase_email

    email = ActionMailer::Base.deliveries.find do |mail|
      mail.subject.include?("First Purchase of #{product.name}")
    end

    expect(email).not_to be_nil
  end
end
