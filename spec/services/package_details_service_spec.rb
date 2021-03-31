# frozen_string_literal: true

require "rails_helper"

RSpec.describe PackageDetailsService, type: :service do
  include_context "packages basic & package details text"
  include_context "parsed package & package details"
  subject { described_class.call(package) }

  describe ".call" do
    let(:package) { create(:package) }
    let(:cran_site_url) { Rails.application.secrets.cran_site_url }
    let(:file_url) { "#{cran_site_url}/#{package.name}_#{package.version}.tar.gz" }
    let(:from_file) { "#{package.name}/DESCRIPTION" }
    let(:extract_text_params) do
      { file_url: file_url, is_tar_file: true, from_file: from_file }
    end

    it "returns the parsed package details" do
      expect(ExtractTextFromFileUrlService).to receive(:call).with(extract_text_params).and_return(package_details_text)

      expect(subject).to eq(package_details)
    end
  end
end
