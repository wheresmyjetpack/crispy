module Persistence
  module Commands
    class Create
      include Command
      operations :create
    end
  end
end
