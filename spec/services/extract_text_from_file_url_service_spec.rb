# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExtractTextFromFileUrlService, type: :service do
  include_context "packages basic & package details text"

  subject { described_class.call(file_url: file_url, is_tar_file: is_tar_file, from_file: from_file) }

  before do
    stub_request(:get, file_url)
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "Ruby",
        }
      )
      .to_return(status: 200, body: file_resource, headers: {})
  end

  describe ".call" do
    context "when file_url is for .gz file only" do
      let(:file_url) { "https://cran.r-project.org/src/contrib/PACKAGES.gz" }
      let(:is_tar_file) { false }
      let(:from_file) { nil }
      let(:file_resource) { file_fixture("PACKAGES.gz") }

      it "downloads the file & extract the text from it" do
        expect(subject).to eq(packages_text)
      end
    end

    context "when file_url is for tar.gz file only" do
      let(:file_url) { "https://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz" }
      let(:is_tar_file) { true }
      let(:file_resource) { file_fixture("A3_1.0.0.tar.gz") }

      context "when from_file exists in the directory" do
        let(:from_file) { "A3/DESCRIPTION" }

        it "downloads the file & extract the text from from_file" do
          expect(subject).to eq(package_details_text)
        end
      end

      context "when from_file doesn't exists in the directory" do
        let(:from_file) { "IncorrectDESCRIPTION" }

        it "returns nil if from_file doesn't exists" do
          expect(subject).to be_nil
        end
      end
    end
  end
end
