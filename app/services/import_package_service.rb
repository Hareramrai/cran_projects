# frozen_string_literal: true

class ImportPackageService < ApplicationService
  BATCH_SIZE = 100
  def initialize(packages)
    @packages = packages
  end

  def call
    Package.delete_all

    Package.import parse_packages, on_duplicate_key_update: {
      conflict_target: [:name, :version],
      columns: [:license, :r_version_needed, :deleted_at],
    }, batch_size: BATCH_SIZE
  end

  private

    attr_reader :packages

    def parse_packages
      parsed_packages = packages.map do |package|
        {
          name: package["Package"],
          version: package["Version"],
          license: package["License"],
          dependencies: package["Depends"],
          deleted_at: nil,
        }
      end

      parsed_packages.uniq { |package| [package[:name], package[:version]].join(":") }
    end
end
