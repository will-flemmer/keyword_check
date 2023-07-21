# frozen_string_literal: true

require "pry"

require_relative "keyword_check/capybara_client"

module KeywordCheck
  class Error < StandardError; end

  class Test # rubocop:disable Style/Documentation
    VALID_RESPONSE_CODES = [
      200,
      202
    ].freeze

    def initialize(remote: false)
      @client = CapybaraClient.new(remote: remote)
    end

    def run(url:, keyword:)
      @url = url
      @keyword = keyword
      @error_message = nil
      run_test
      format_result
    end

    private

    def run_test
      @client.page.visit(@url)
      return unless valid_response_code?

      keyword_found?
    end

    def errors
      return "Keyword not found on page" unless @client.page.has_text?(@keyword)
    end

    def valid_response_code?
      return true if VALID_RESPONSE_CODES.include?(@client.page.status_code)

      @error_message = "Page loaded unsuccesfully, status Code: #{@client.page.status_code}"
    end

    def keyword_found?
      return true if @client.page.has_text?(@keyword)

      @error_message = "Keyword not found on page"
    end

    def format_result
      {
        url: @url,
        keyword: @keyword,
        success: @error_message.nil?,
        error_message: @error_message
      }
    end
  end
end
