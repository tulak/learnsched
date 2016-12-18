module ApplicationHelper

  def error_messages model
    return nil unless model.errors.any?
    render partial: 'layouts/error_messages', locals: { model: model }
  end
end
