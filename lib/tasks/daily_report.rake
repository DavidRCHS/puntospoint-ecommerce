namespace :resque do
  desc "Enqueue daily report worker"
  task enqueue_daily_report: :environment do
    Resque.enqueue(DailyReportJob)
    puts "Job de reporte diario encolado."
  end
end