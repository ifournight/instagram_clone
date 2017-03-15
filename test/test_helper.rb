ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ActionDispatch::TestProcess
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

  def help_create_activation_digest(user)
    user.activation_token = User.new_token
    user.update_columns(activation_digest: User.digest(user.activation_token))
  end

  def generate_unique_email
    @@email_count ||= 0
    @@email_count += 1
    "test#{@@email_count}@example.com"
  end

  def generate_unique_name
    @@name_count ||= 0
    @@name_count += 1
    "test#{@@name_count}"
  end

  def valid_attributes(attributes={})
    { name: generate_unique_name,
      email: generate_unique_email,
      password: 'password',
      password_confirmation: 'password' }.update(attributes)
  end

  def new_user(attributes={})
    User.new(valid_attributes(attributes))  
  end

  def create_user(attributes={})
    User.create!(valid_attributes(attributes))
  end

  def create_user_without_confirmation(attributes={})
    user = new_user(attributes)
    user.skip_confirmation!
    user.save!
    user
  end

  def gravatar_url_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def generate_picture
    fixture_file_upload('test/fixtures/rails.png', 'image/png')
  end

  def valid_post_attributes(attributes={})
    { content: 'blabla',
      picture: generate_picture,
      user_id: create_user.id}.update(attributes)
  end

  def new_post(attributes={})
    Post.new(valid_post_attributes(attributes))
  end

  def create_post(attributes={})
    Post.create!(valid_post_attributes(attributes))
  end

  def valid_comment_attributes(attributes={})
    { content: 'blabla',
      user_id: create_user.id,
      post_id: create_post.id
    }.update(attributes)
  end

  def new_comment(attributes)
    Comment.new(valid_comment_attributes(attributes))
  end

  def create_comment(attributes)
    Comment.create!(valid_comment_attributes(attributes))
  end
end
