require 'spec_helper'

RSpec.describe Mobilepay do
    it 'has a version number' do
        expect(Mobilepay::VERSION).not_to be nil
    end
end
