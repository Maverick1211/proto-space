module LikesHelper
  def like_button(proto)
    if user_signed_in? && proto.like_user(current_user)
      like = proto.like_user(current_user)
      button_to [proto, like], { method: :delete, remote: true } do
        yield
      end
    elsif user_signed_in?
      button_to proto_likes_path(proto), remote: true do
        yield
      end
    else
      button_to new_user_session_path do
        yield
      end
    end
  end

  def like_image(proto)
    if user_signed_in? && proto.like_user(current_user)
      image_tag('icon_red_heart.svg')
    else
      image_tag('icon_heart.svg')
    end
  end

  def likes_count(likes)
    content_tag(:span, likes)
  end
end
