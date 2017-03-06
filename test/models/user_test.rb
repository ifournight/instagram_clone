require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @ifournight = users(:ifournight)
    @momo = users(:momo)
  end
  test 'user name should not be blank' do
    invalid = ['', '    ']
    invalid.each do |invalid_name|
      @ifournight.name = invalid_name
      assert @ifournight.invalid?
      assert_not @ifournight.errors[:name].empty?
    end
  end

  test 'user name should be unique' do
    user = User.new(name: @ifournight.name,
                    email: "uniqueness_#{rand(1000)}@email.com",
                    password: 'password',
                    password_confirmation: 'password')
    assert user.invalid?
    assert_not user.errors[:name].empty?
    assert_equal user.errors[:name][0], "Hey, User Name '#{@ifournight.name}' is already been taken!"
  end

  test 'user email should not be blank' do
    @ifournight.email = ''
    assert @ifournight.invalid?
    assert_not @ifournight.errors[:email].empty?
  end

  test 'user email should be unique' do
    user = User.new(name: "unqiuename_#{rand(1000)}",
                    email: @ifournight.email,
                    password: 'password',
                    password_confirmation: 'password')
    assert user.invalid?
    assert_not user.errors[:email].empty?
    assert_equal user.errors[:email][0], "Hey, Email '#{@ifournight.email}' is already been taken!"
  end

  test 'user password validation test' do
    user = User.new(name: "uniquename_#{rand(1000)}",
                    email: "uniquemail_#{rand(1000)}@email.com",
                    password: '',
                    password_confirmation: '')
    assert user.invalid?
    assert_not user.errors[:password].empty?

    user.password = 'password'
    user.password_confirmation = 'password_different'
    assert user.invalid?
    assert_not user.errors[:password_confirmation].empty?
  end
end
