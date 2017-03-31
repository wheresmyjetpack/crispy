module Users
  class PrepareForCreate < Transproc::Transformer[Operations]
    symbolize_keys
    constructor_inject Users::Entity
  end
end
