require 'test_helper'

class StatusMessagesControllerTest < ActionDispatch::IntegrationTest
  test 'index page should show last status banner and previous status list' do
    get root_path

    assert_response :success

    statuses = StatusMessage.recent
    assert_select 'section#last_status' do
      assert_select "i.#{statuses.first.status}"
      assert_select 'h3', statuses.first.message
      assert_select 'span', statuses.first.created_at.strftime('%Y/%m/%d - %H:%M:%S')
    end

    assert_select 'section#recent_status' do
      assert_select 'ul' do
        statuses[1..].each do |s|
          assert_select "li##{s.id}" do
            assert_select 'span', s.message
            assert_select 'span', s.created_at.strftime('%Y/%m/%d - %H:%M:%S')
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
      assert_select 'i.no-status'
      assert_select 'h3'
    end
  end

  test 'new page should show form with latest status and message' do
    get new_status_message_path

    assert_response :success

    last_status = StatusMessage.recent.first
    assert_select 'form[action=?]', status_messages_path do
      assert_select 'label[for=status_message_message]'
      assert_select 'input[name="status_message[message]"]', value: last_status.message
      assert_select 'label[for=status_message_status]'
      assert_select 'select[name="status_message[status]"]' do
        assert_select 'option[value=up]', selected: last_status.status == :up
        assert_select 'option[value=down]', selected: last_status.status == :down
      end
      assert_select 'button[type=submit]'
    end
  end

  test 'new page should empty show form with up status and no message, if there is no recent status' do
    StatusMessage.delete_all

    get new_status_message_path

    assert_response :success

    assert_select 'form[action=?]', status_messages_path do
      assert_select 'label[for=status_message_message]'
      assert_select 'input[name="status_message[message]"]', value: ''
      assert_select 'label[for=status_message_status]'
      assert_select 'select[name="status_message[status]"]' do
        assert_select 'option[value=up]', selected: true
        assert_select 'option[value=down]', selected: false
      end
      assert_select 'button[type=submit]'
    end
  end
end
