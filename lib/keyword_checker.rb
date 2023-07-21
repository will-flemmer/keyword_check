# frozen_string_literal: true

require_relative "keyword_checker/capybara_client"

module KeywordChecker
  class Error < StandardError; end

  class Test # rubocop:disable Style/Documentation
    VALID_RESPONSE_CODES = [
      200,
      202
    ].freeze

    def initialize(capybara_client: nil)
      @client = capybara_client || CapybaraClient.new
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

    def valid_response_code?
      return true if VALID_RESPONSE_CODES.include?(@client.page.status_code)

      @error_message = "Error rendering page, status Code: #{@client.page.status_code}"
      false
    end

    def keyword_found?
      return true if @client.page.has_text?(@keyword)

      @error_message = "Keyword not found on page"
      false
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
