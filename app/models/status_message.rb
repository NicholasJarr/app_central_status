class StatusMessage < ApplicationRecord
  MESSAGE_MAXIMUM_LENGTH = 500

  enum status: {
    up: 0,
    down: 1
  }

  # Can't be greater than maximum
  validates :message,
            presence: true,
            length: { maximum: MESSAGE_MAXIMUM_LENGTH }

  validates :status,
            presence: true

  # Returns the most recent 6 items for displaying in the home page
  scope :recent, -> { order(created_at: :desc).limit(6) }
end
