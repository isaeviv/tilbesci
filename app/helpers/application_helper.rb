module ApplicationHelper
  STATE_COLOR_CLASSES = {
    "pending" =>      "is-warning",
    "translated" =>   "is-success",
    "in_progress" =>  "is-info"
  }
  
  def state_tag_for resource
    return unless resource.try :state

    tag_class = "tag mx-3 ".concat(STATE_COLOR_CLASSES[resource.state])

    content_tag :span, class: tag_class do
      resource.state_text
    end
  end
end
