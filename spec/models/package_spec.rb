# frozen_string_literal: true

require "rails_helper"

RSpec.describe Package, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:version) }
    it { should validate_uniqueness_of(:name).scoped_to(:version) }
  end
end
