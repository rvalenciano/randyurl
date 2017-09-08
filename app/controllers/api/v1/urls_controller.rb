# frozen_string_literal: true

module Api::V1
  class UrlsController < ApiController
    # GET /v1/users
    def index
      render json: Url.all
    end

    def top
      render json: Url.top(100)
    end
  end
end
