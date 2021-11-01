module StatusMessagesHelper
  # Helper for generation an icon tag for a status_message
  # i.bi.bi-check-lg if up
  # i.bi.bi-x-lg if down
  def icon_for_status(status_message)
    if status_message.up?
      content_tag :i, '', class: 'up bi bi-check-lg'
    else
      content_tag :i, '', class: 'down bi bi-x-lg'
    end
  end
end
