class AuthorizationContext
  attr_reader :user, :cookies

  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end
end
