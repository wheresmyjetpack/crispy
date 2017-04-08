module Users
  class PrepareForCreate < Transproc::Transformer[Operations]
    symbolize_keys
    map_value :first_name { capitalize_string }
    map_value :last_name { capitalize_string }
    constructor_inject Users::Entity
  end
end
