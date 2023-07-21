# frozen_string_literal: true

require "capybara/cuprite"
require "capybara"
require "capybara/dsl"

module KeywordChecker
  class CapybaraClient # rubocop:disable Style/Documentation
    include Capybara::DSL
    def initialize
      Capybara.javascript_driver = :cuprite
      Capybara.register_driver(:cuprite) do |app|
        Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
      end
      Capybara.current_driver = :cuprite
    end
  end
end
