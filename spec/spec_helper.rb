require 'rspec'
require 'wisper/rspec/matchers'
require 'byebug'

$LOAD_PATH.unshift File.expand_path '../../app', __FILE__
$LOAD_PATH.unshift File.expand_path '../..', __FILE__

require 'rubygems'
require 'active_support/all'
require 'ostruct'
require 'rectify'
require 'dry-struct'
require 'dry-types'
require 'app/core/types'


RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.backtrace_exclusion_patterns ||= []
  config.backtrace_exclusion_patterns.push(/bundler/, /rspec-core/)
  config.alias_it_should_behave_like_to :it_has_behavior, 'has behvaior:'

  config.include(Wisper::RSpec::BroadcastMatcher)
end

def ostruct(*args, &block)
  OpenStruct.new(*args, &block)
end
