require 'bundler/setup'
Bundler.setup

require 'telos'

RSpec::Matchers.define :byte_eq do |expected|
  match do |actual|
    actual.bytes == expected.bytes
  end
end
