# frozen_string_literal: true

RSpec.describe KeywordChecker do
  let(:url) { "https://quotes.toscrape.com/" }
  let(:keyword) { "Quotes to Scrape" }

  describe "on success" do
    let(:test) { KeywordChecker::Test.new }

    it "returns a response on success" do
      result = test.run(url: url, keyword: keyword)
      expect(result[:error_message]).to eq(nil)
      expect(result[:success]).to eq(true)
    end
  end

  describe "failure cases" do
    let(:test) { KeywordChecker::Test.new }

    it "fails when the response code is not 200" do
      result = test.run(url: "#{url}/not/a/real/url", keyword: keyword)
      expect(result[:error_message]).to eq("Error rendering page, status Code: 404")
      expect(result[:success]).to eq(false)
    end

    it "fails when the keyword is not found" do
      result = test.run(url: url, keyword: "#{keyword}-not-found")
      expect(result[:error_message]).to eq("Keyword not found on page")
      expect(result[:success]).to eq(false)
    end
  end
end
