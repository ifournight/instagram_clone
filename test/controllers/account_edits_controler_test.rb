require 'test_helper'

class AccountEditsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::TextHelper

  def setup
    @user = create_user
    sign_in(@user)
  end

  test 'should render new page' do
    get new_account_edit_url

    assert_response :success
    assert_template 'account_edits/new'

    assert_select "input[name='account_edit[name]']"
    assert_select "input[name='account_edit[email]']"
  end

  test 'edit should fail with invalid params' do
    get new_account_edit_url

    invalid_acount_edit_list =
    [
      { name: '', email: generate_unique_email },
      { name: generate_unique_name, email: '' }
      # { name: generate_unique_name, email: @user.email }
    ]

    invalid_acount_edit_list.each do |edit_attr|
      post account_edits_path, params: { account_edit: edit_attr }
      account_edit = assigns(:account_edit)

      assert account_edit.errors.any?
      @user.reload

      assert_response :success
    end
  end

  test 'edit should success with valid params' do
    get new_account_edit_url

    valid_account_edit_list =
    [
      { name: @user.name, email: generate_unique_email },
      { name: generate_unique_name, email: generate_unique_email }
    ]

    valid_account_edit_list.each do |edit_attr|
      post account_edits_path, params: { account_edit: edit_attr }
      account_edit = assigns(:account_edit)

      assert_not account_edit.errors.any?
      @user.reload

      assert_equal @user.name, edit_attr[:name]
      # below would not be true because Devise will guard on @user.email change,
      # and send a confirmation mailer
      # assert_equal @user.email, edit_attr[:email]

      assert_redirected_to new_account_edit_url
    end
  end
end
