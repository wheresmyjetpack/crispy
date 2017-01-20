module NavHelper
  def current_user_id
    return nil if current_user.nil?
    current_user.id
  end
end
