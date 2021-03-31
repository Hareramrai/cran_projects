# frozen_string_literal: true

class SyncPackageListService < ApplicationService
  PACKAGE_LIST_FILE_PATH = "PACKAGES.gz"

  def call
    packages = extract_text_and_parse_debian_file
    imported_records = ImportPackageService.call(packages)
    sync_packages_details(imported_records.ids)
  end

  private

    def extract_text_and_parse_debian_file
      file_text = ExtractTextFromFileUrlService.call(file_url: file_url)
      DebianFileParserService.call(file_text)
    end

    def file_url
      "#{Rails.application.secrets.cran_site_url}/#{PACKAGE_LIST_FILE_PATH}"
    end

    def sync_packages_details(package_ids)
      package_ids.map { |id| SyncPackageDetailsJob.perform_later(id) }
    end
end
