module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'notice'
      'alert-success'
    when 'error'
      'alert-danger'
    else
      flash_type.to_s
    end
  end

  def user_status(user)
    if signed_in?
      render partial: 'layouts/user_in'
    else
      render partial: 'layouts/user_out'
    end
  end
end