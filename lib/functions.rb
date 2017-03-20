require 'transproc/all'

module Functions
  extend Transproc::Registry

  import Transproc::Coercions
  import Transproc::ArrayTransformations
  import Transproc::HashTransformations
  import Transproc::ClassTransformations
  import Transproc::ProcTransformations
  import Transproc::Conditional
  import Transproc::Recursion
end
