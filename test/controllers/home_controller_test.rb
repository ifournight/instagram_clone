require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "set locale should do nothing if call with invalid locale" do
    get sign_up_url

    invalid_locale_list = ['', :de, :jp]
    invalid_locale_list.each do |invalid_locale|
      post set_locale_path, params: { locale: invalid_locale }

      assert_response :success
    end
  end

  test 'call with valid locale with store required localed in cookkies' do
    valid_locale_list = [:en, 'zh-CN']
    valid_locale_list.each do |valid_locale|
      post set_locale_path, params: { locale: valid_locale }

      assert_response :redirect
      # assert_equal cookies[:locale], valid_locale
    end
  end
end
