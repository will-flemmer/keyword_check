# frozen_string_literal: true
require "capybara/cuprite"
require "capybara"
require "capybara/dsl"

module KeywordCheck
  class CapybaraClient # rubocop:disable Style/Documentation
    include Capybara::DSL
    def initialize(remote:)
      Capybara.javascript_driver = :cuprite
      Capybara.register_driver(:cuprite) do |app|
        Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
      end
      Capybara.current_driver = :cuprite
      # page = Browser.new.page
      # page.visit("http://www.google.com")
      # puts(page.html)
    end
  end
end
