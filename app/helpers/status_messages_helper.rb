module StatusMessagesHelper
  def icon_for_status(status_message)
    if status_message.up?
      content_tag :i, '', class: 'up bi-check-lg'
    else
      content_tag :i, '', class: 'down bi-x-lg'
    end
  end
end
