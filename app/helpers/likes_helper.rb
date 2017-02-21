module LikesHelper
  def like_button(proto)
    if user_signed_in? && current_user.like(proto)
      like = current_user.like(proto)
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
    if user_signed_in? && current_user.like(proto)
      image_tag('icon_red_heart.svg')
    else
      image_tag('icon_heart.svg')
    end
  end
end
