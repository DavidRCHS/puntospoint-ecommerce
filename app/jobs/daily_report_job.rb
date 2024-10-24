class DailyReportJob
  @queue = :reports

  def self.perform
    start_date = 1.day.ago.beginning_of_day
    end_date = 1.day.ago.end_of_day
    purchases = Purchase.where(created_at: start_date..end_date)

    if purchases.any?
      DailyReportMailer.send_report(purchases).deliver
      puts "Reporte diario enviado a los administradores."
    else
      puts "No hubo compras el dia anterior."
    end
  end
end
