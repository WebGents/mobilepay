require_relative 'mobilepay/version'
require_relative 'mobilepay/client'
require_relative 'mobilepay/security'

module Mobilepay
    class Failure < StandardError; end
end
