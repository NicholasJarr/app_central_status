require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'status_messages/index'

    assert_select 'nav a[href=?]', root_path
    assert_select 'nav a[href=?]', new_status_message_path
  end
end
