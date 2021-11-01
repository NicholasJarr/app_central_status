require "test_helper"

class StatusMessageCreationTest < ActionDispatch::IntegrationTest
  test 'new page should create a status if the params is valid, and redirect home with flash' do
    # TODO: Use FactoryGirl
    StatusMessage.delete_all

    get new_status_message_path
    assert_response :success

    assert_difference 'StatusMessage.count', 1 do
      post status_messages_path, params: { status_message: { message: 'test',
                                                             status: :up } }
    end

    follow_redirect!

    assert_template 'status_messages/index'
    assert_response :success

    assert flash[:success]

    assert_select 'section#last_status' do
      assert_select 'p', 'test'
    end
  end

  test 'new page should not a status if the params is invalid, and rerender the form' do
    get new_status_message_path
    assert_response :success

    assert_no_difference 'StatusMessage.count' do
      post status_messages_path, params: { status_message: { message: '',
                                                             status: :up } }
    end

    assert_response :success
    assert_template 'status_messages/new'

    assert_not flash[:success]

    status_being_created = assigns(:status)

    assert_select 'div#error_explanation' do
      assert_select 'ul' do
        status_being_created.errors.full_messages.each do |m|
          assert_select 'li', m
        end
      end
    end
  end
end
