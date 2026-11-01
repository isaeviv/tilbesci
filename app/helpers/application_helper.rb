module ApplicationHelper
  STATE_COLOR_CLASSES = {
    "pending" =>      "is-warning",
    "translated" =>   "is-success",
    "in_progress" =>  "is-info"
  }

  LOCALE_COLOR_CLASSES = {
    "kjh" => "is-success",
    "ru" => "is-warning",
    "en" => "is-danger",
    "eo" => "is-primary",
    'isv' => "is-info"
  }
  
  def state_tag_for resource
    return unless resource.try :state

    tag_class = "tag mx-3 ".concat(STATE_COLOR_CLASSES[resource.state])

    content_tag :span, class: tag_class do
      resource.state_text
    end
  end

  def locale_tag locale
    tag_class = "tag mx-3 ".concat(LOCALE_COLOR_CLASSES[locale.to_s])
    content_tag :span, class: tag_class do
      locale
    end
  end
end
