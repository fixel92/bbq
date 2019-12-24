module UsersHelper
  def min_pass_len
    "(#{@minimum_password_length} символов минимум)" if @minimum_password_length
  end
end
