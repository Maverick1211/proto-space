module LikesHelper
  def user_login?(user_condition, user_likes, proto, likes)
    if user_condition
      user_liked?(user_likes, proto, likes)
    else
      button_to new_user_session_path do
        "#{image_tag('icon_heart.svg')}
         #{likes_count(likes)}".html_safe
      end
    end
  end

  def user_liked?(condition, proto, likes)
    if like = condition
      button_to proto_like_path(proto, like), method: :delete, id: 'like-buttons', remote: true do
        "#{image_tag('icon_red_heart.svg')}
         #{likes_count(likes)}".html_safe
      end
    else
      button_to proto_likes_path(proto), id: 'like-buttons', remote: true do
        "#{image_tag('icon_heart.svg')}
         #{likes_count(likes)}".html_safe
      end
    end
  end

  def likes_count(likes)
    content_tag(:span, likes)
  end
end
