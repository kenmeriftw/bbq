module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert-info"
      when :success then "alert-success"
      when :error then "alert-danger"
      when :alert then "alert-warning"
      else "alert-#{flash_type}"
    end
  end

  def user_avatar(user)
    # TODO
    asset_pack_path('media/images/userpic.jpeg')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
