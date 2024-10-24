class Api::V1::PurchasesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    purchases = Purchase.scoped

    purchases = purchases.where('purchases.created_at >= ?', params[:from]) if params[:from].present?
    purchases = purchases.where('purchases.created_at <= ?', params[:to]) if params[:to].present?
    purchases = purchases.joins(product: :categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    purchases = purchases.where(customer_id: params[:customer_id]) if params[:customer_id].present?
    purchases = purchases.joins(product: :admin).where(admins: { id: params[:admin_id] }) if params[:admin_id].present?

    render json: purchases
  end

  def count_by_granularity
    purchases = Purchase.scoped

    purchases = purchases.where('purchases.created_at >= ?', params[:from]) if params[:from].present?
    purchases = purchases.where('purchases.created_at <= ?', params[:to]) if params[:to].present?
    purchases = purchases.joins(product: :categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    purchases = purchases.where(customer_id: params[:customer_id]) if params[:customer_id].present?
    purchases = purchases.joins(product: :admin).where(admins: { id: params[:admin_id] }) if params[:admin_id].present?

    case params[:granularity]
    when 'hour'
      results = purchases.group('DATE_TRUNC(\'hour\', purchases.created_at)').count
    when 'day'
      results = purchases.group('DATE_TRUNC(\'day\', purchases.created_at)').count
    when 'week'
      results = purchases.group('DATE_TRUNC(\'week\', purchases.created_at)').count
    when 'year'
      results = purchases.group('DATE_TRUNC(\'year\', purchases.created_at)').count
    else
      render json: { error: 'Invalid granularity' }, status: :unprocessable_entity and return
    end

    render json: results
  end
end
