class StatusMessagesController < ApplicationController
  def index
    @statuses = StatusMessage.recent
  end

  def new
    recent_status = StatusMessage.recent.first
    @status = StatusMessage.new message: recent_status&.message || '',
                                status: recent_status&.status || :up
  end

  def create
    @status = StatusMessage.new status_message_params
    if @status.save
      flash[:success] = 'Updated status'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def status_message_params
    params.require(:status_message).permit(:message, :status)
  end
end
