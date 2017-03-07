ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def extract_activation_token(text)
    activation_token = ''
    text.scan(URI.regexp) do |match|
      # match url
      match.each do |piece|
        # url piece
        next if piece.nil?
        piece.match(/^activation_token=(.*)/ix) do |token|
          activation_token = token[1]
        end
      end
    end
    activation_token
  end
end
