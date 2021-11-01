require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'status_messages/index'

    assert_select 'a[href=?]', root_path
  end
end
