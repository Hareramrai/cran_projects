# frozen_string_literal: true

class PackageDetailsService < ApplicationService
  DESCRIPTION_FILE_NAME = "DESCRIPTION"

  def initialize(package)
    @package = package
  end

  def call
    parse_package extract_text_and_parse_debian_file
  end

  private

    attr_reader :package

    def package_url
      "#{cran_site_url}/#{package.name}_#{package.version}.tar.gz"
    end

    def cran_site_url
      Rails.application.secrets.cran_site_url
    end

    def extract_text_and_parse_debian_file
      file_text = ExtractTextFromFileUrlService
                  .call(file_url: package_url, is_tar_file: true, from_file: from_file)

      DebianFileParserService.call(file_text).first
    end

    def from_file
      "#{package.name}/#{DESCRIPTION_FILE_NAME}"
    end

    def parse_package(package_deatils)
      {
        name: package_deatils["Package"],
        title: package_deatils["Title"],
        version: package_deatils["Version"],
        license: package_deatils["License"],
        dependencies: package_deatils["Depends"],
        maintainers: package_deatils["Maintainer"],
        authors: package_deatils["Author"],
        date_and_publication: package_deatils["Date/Publication"],
        r_version_needed: r_version(package_deatils),
      }
    end

    def r_version(package_deatils)
      package_deatils["Depends"]
        .split(",")
        .find { |dependency| dependency.start_with?("R (") }[2..]
    end
end
