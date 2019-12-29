module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-danger'
      when 'alert' then 'alert alert-warning'
    end
  end

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('avatar.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path('avatar.jpg')
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event_thumb.jpg')
    end
  end
end
