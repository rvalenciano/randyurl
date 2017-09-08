# frozen_string_literal: true

module Api::V1
  class UrlsController < ApiController
    def index
      render json: Url.all, status: :ok
    end

    def top
      render json: Url.top(100), status: :ok
    end

    def create
      @url = Url.new
      @url.process_url(params[:url])
      if @url.save
        render json: @url, status: :created 
      else
        render json: @url.errors, status: :unprocessable_entity
      end
    rescue => e
      render json: e, status: :unprocessable_entity
    end
  end
end
