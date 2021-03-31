# frozen_string_literal: true

require "rails_helper"

RSpec.describe SyncPackageListService, type: :service do
  include_context "parsed package & package details"
  subject { described_class.call }

  describe ".call" do
    let(:file_url) { "#{Rails.application.secrets.cran_site_url}/PACKAGES.gz" }
    let(:extract_respose_text) do
      <<~FILE_TEXT
        Package: XML
        Version: 1.0.0
        Depends: R (>= 2.15.0), xtable, pbapply
        License: MIT
      FILE_TEXT
    end
    let(:packages) { [package] }
    let(:package_id) { 1 }
    let(:imported_records) { double(:imported_records, ids: [package_id]) }

    it "calls the extract text serivce followed by import & then enqueue SyncPackageDetailsJob" do
      expect(ExtractTextFromFileUrlService).to receive(:call).with(file_url: file_url).and_return(extract_respose_text)
      expect(ImportPackageService).to receive(:call).with(packages).and_return(imported_records)
      expect(SyncPackageDetailsJob).to receive(:perform_later).with(package_id)

      subject
    end
  end
end
