# frozen_string_literal: true

module Api::V1
  class UrlsController < ApiController
    def index
      render json: Url.all, status: :ok
    end

    def top
      render json: Url.top(100), status: :ok
    end

    def redirect
      # Url.lookup(params[:id])
      url = Url.lookup(params[:id])
      redirect_to url
    end

    def lookup
      url = Url.lookup(params[:id])
      render json: {short_url: url}
    end

    def bot
      Url.delete_all
      mechanize = Mechanize.new
      page = mechanize.get('http://en.wikipedia.org/wiki/Main_Page/')
      created_objects = []
      # We will follow random articles from wikipedia 150 times
      5.times do
        link = page.link_with(text: 'Random article')
        page = link.click
        u = Url.process_url(page.uri)
        created_objects << u
      end
      render json: created_objects
    end

    def create
      # if is not in cache, we create it
      @url = Url.process_url(params[:url])
      begin
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
