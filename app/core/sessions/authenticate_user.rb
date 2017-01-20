module Sessions
  class AuthenticateUser < Rectify::Command
    def initialize(email:, password:, user_relation: User)
      @email = email
      @password = password
      @user_relation = user_relation
    end

    def call
      user = user_relation.find_by_email(email.downcase)
      if user && user.authenticate(password)
        broadcast(:ok, user)
      else
        broadcast(:danger)
      end
    end

    private

    attr_reader :email, :password, :user_relation
  end
end
