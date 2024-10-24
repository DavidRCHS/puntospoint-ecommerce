class Api::V1::VersionsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    versions = Version.where(item_type: params[:item_type], item_id: params[:item_id])
    render json: versions
  end
end
