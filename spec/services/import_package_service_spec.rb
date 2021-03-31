# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportPackageService, type: :service do
  include_context "parsed package & package details"
  subject { described_class.call(packages) }

  describe "call" do
    let(:packages) { [package] }

    context "when no exisiting data in table" do
      it "imports the package" do
        expect { subject }.to change { Package.count }.by(1)
      end
    end

    context "when there a record in table" do
      let!(:exisiting_package) { create(:package) }

      it "deletes all the package if missing in imports data" do
        subject
        expect(exisiting_package.reload).to be_deleted
      end
    end

    context "when packages has duplicate record" do
      let(:packages) { [package, package] }

      it "doesn't create multiple entries" do
        expect { subject }.to change { Package.count }.by(1)
      end
    end
  end
end
