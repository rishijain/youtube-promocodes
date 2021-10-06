class PromocodesController < ApplicationController

  def create
    if params[:video_url]
      DoAll.new(params[:video_url]).exec
      render json: { message: 'Codes are extracted'}, status: :ok
    else
      render json: { message: 'could not find correct video url'}, status: :unprocessable_entity
    end
  end
end
