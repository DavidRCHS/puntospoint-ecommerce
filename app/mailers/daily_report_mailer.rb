class DailyReportMailer < ActionMailer::Base
  default from: 'no-reply@example.com'

  def send_report(purchases)
    @purchases = purchases
    admin_emails = Admin.all.map(&:email).uniq

    mail(
      to: admin_emails,
      subject: "Reporte de Compras del Dia Anterior"
    )
  end
end
