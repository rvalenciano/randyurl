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
      # if is not in cache, we create it
      @url = Url.new
      begin
        @url.process_url(params[:url])
        if @url.save
          render json: @url, status: :created
        else
          render json: @url.errors, status: :unprocessable_entity
        end
      rescue => exception
        render json: @url.errors, status: :unprocessable_entity
      else
      ensure
      end
    end
  end
end
