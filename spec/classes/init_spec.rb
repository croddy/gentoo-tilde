require 'spec_helper'
describe 'tilde' do

  context 'with defaults for all parameters' do
    it { should contain_class('tilde') }
  end
end
