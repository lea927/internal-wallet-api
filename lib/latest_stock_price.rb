# frozen_string_literal: true
require 'uri'
require 'net/http'

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"

    def initialize(api_key)
      @api_key = api_key
    end

    def price(ticker)
      url = URI("#{BASE_URL}/price?Indices=#{ticker}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = ENV['RAPID_API_KEY']
      request["X-RapidAPI-Host"] = ENV['RAPID_API_HOST']

      response = http.request(request)
      response.read_body
    end

    def prices(tickers)
      tickers_param = tickers.join('%20')
      url = URI("#{BASE_URL}/price?Indices=#{tickers_param}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = ENV['RAPID_API_KEY']
      request["X-RapidAPI-Host"] = ENV['RAPID_API_HOST']

      response = http.request(request)
      response.read_body
    end

    def price_all
      url = URI("#{BASE_URL}/any")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = ENV['RAPID_API_KEY']
      request["X-RapidAPI-Host"] = ENV['RAPID_API_HOST']

      response = http.request(request)
      response.read_body
    end
  end
end

