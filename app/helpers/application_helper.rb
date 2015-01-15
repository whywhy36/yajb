module ApplicationHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      'WORK@HOME | remote working information'
    end
  end

  def meta_keywords(keywords = nil)
    if keywords.present?
      content_for :meta_keywords, keywords
    else
      'remote working, remote work, remote, telecommuting, work from home, work at home'
    end
  end

  def meta_description(description = nil)
    if description.present?
      content_for :meta_description, description
    else
      'Job board for remote working'
    end
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat message
      end)
    end
    nil
  end
end
