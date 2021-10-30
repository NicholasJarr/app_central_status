require 'test_helper'

class StatusMessagesControllerTest < ActionDispatch::IntegrationTest
  test 'index page should show last status banner and previous status list' do
    get root_path

    assert_response :success

    statuses = StatusMessage.recent
    assert_select 'section#last_status' do
      assert_select 'img'
      assert_select 'p', statuses.first.message
      assert_select 'sub', statuses.first.created_at.strftime('%Y/%m/%d - %H/%M/%S')
      assert_select 'a[href=?]', new_status_message_path, 'Update status'
    end

    assert_select 'section#recent_status' do
      assert_select 'ul' do
        statuses[1..].each do |s|
          assert_select "li##{s.id}" do
            assert_select 'span', s.message
            assert_select 'sub', s.created_at.strftime('%Y/%m/%d - %H:%M:%S')
          end
        end
      end
    end
  end

  test 'index page should show empty message and image if there is no status' do
    StatusMessage.delete_all

    get root_path

    assert_response :success

    assert_select 'section#last_status', count: 0
    assert_select 'section#recent_status', count: 0

    assert_select 'section#no_status' do
      assert_select 'img'
      assert_select 'p'
      assert_select 'a[href=?]', new_status_message_path, 'Update status'
    end
  end
end
