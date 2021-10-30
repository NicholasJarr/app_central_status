class StatusMessage < ApplicationRecord
  MESSAGE_MAXIMUM_LENGTH = 500

  enum status: {
    up: 0,
    down: 1
  }

  validates :message,
            presence: true,
            length: { maximum: MESSAGE_MAXIMUM_LENGTH }

  validates :status,
            presence: true

  scope :recent, -> { order(created_at: :desc).limit(6) }
end
