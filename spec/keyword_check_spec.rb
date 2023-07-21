# frozen_string_literal: true

RSpec.describe KeywordCheck do
  describe "on success" do
    let(:test) { KeywordCheck::Test.new }

    it "returns a response on success" do
      result = test.run(url: "https://google.com", keyword: "Google")
      expect(result[:success]).to eq(true)
      expect(result[:error_message]).to eq(nil)
    end
  end
end
