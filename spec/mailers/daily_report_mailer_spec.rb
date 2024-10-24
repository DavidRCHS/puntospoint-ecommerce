require 'spec_helper'

describe DailyReportMailer do
  let!(:admin) { Admin.create!(name: 'Admin', email: 'admin@example.com') }
  let!(:product) { Product.create!(name: 'Smartphone', description: 'Test Product', price: 399.99, admin: admin) }
  let!(:customer) { Customer.create!(name: 'John Doe', email: 'john@example.com') }
  let!(:purchase) { Purchase.create!(product: product, customer: customer, quantity: 1, total_price: 399.99, created_at: 1.day.ago) }

  it 'sends an email to all admins with the daily report' do
    mail = DailyReportMailer.send_report([purchase])

    expect(mail.to).to include(admin.email)
    expect(mail.subject).to eq("Reporte de Compras del Dia Anterior")
    expect(mail.body.encoded).to include('Smartphone')
    expect(mail.body.encoded).to include('John Doe')
    expect(mail.body.encoded).to include('399.99')
  end
end