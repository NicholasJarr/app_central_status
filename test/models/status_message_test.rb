require "test_helper"

class StatusMessageTest < ActiveSupport::TestCase
  test 'valid status message should be created' do
    assert StatusMessage.new(
      message: 'test',
      status: :up
    ).valid?
  end

  test 'messages must be present' do
    assert StatusMessage.new(
      message: nil,
      status: :up
    ).invalid?

    assert StatusMessage.new(
      message: '',
      status: :up
    ).invalid?

    assert StatusMessage.new(
      message: '  ',
      status: :up
    ).invalid?
  end

  test 'messages too big should be invalid' do
    assert StatusMessage.new(
      message: 'a' * StatusMessage::MESSAGE_MAXIMUM_LENGTH * 2,
      status: :up
    ).invalid?
  end

  test 'status must be present' do
    assert StatusMessage.new(
      message: 'test',
      status: nil
    ).invalid?
  end

  test 'recent scope should be bring the top 6 status ordered by created_at' do
    expected_items = status_messages.sort { |a, b| b.created_at <=> a.created_at }[0..5]
    actual_statuses = StatusMessage.recent.to_a

    assert_equal 6, actual_statuses.length
    assert_equal expected_items, actual_statuses
  end
end
