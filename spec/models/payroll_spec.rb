require 'rails_helper'

RSpec.describe Payroll, type: :model do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:starts_at) }
    it { is_expected.to validate_uniqueness_of(:ends_at) }
    it { is_expected.to validate_presence_of(:starts_at) }
    it { is_expected.to validate_presence_of(:ends_at) }
  end
end
