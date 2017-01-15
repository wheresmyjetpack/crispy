module Sessions
  class AuthenticateUser < Rectify::Command
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email.downcase)
      if user && user.authenticate(password)
        broadcast(:ok, user)
      else
        broadcast(:danger)
      end
    end

    private

    attr_reader :email, :password
  end
end
