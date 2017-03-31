module Users
  class Entity < Dry::Struct
    constructor_type :strict

    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :email, Types::Email
    attribute :password, Types::String
    attribute :password_confirmation, Types::String

    def validate
      schema = Dry::Validation.Form do 
        required(:email).filled
        required(:password).filled(min_size?: 10).confirmation
        required(:password_confirmation).filled
        required(:first_name).filled
        required(:last_name).filled
      end

      schema.call(**self)
    end
  end
end
