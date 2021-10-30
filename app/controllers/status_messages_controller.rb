class StatusMessagesController < ApplicationController
  def index
    @statuses = StatusMessage.recent
  end

  def new
  end
end
