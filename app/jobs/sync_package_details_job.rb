# frozen_string_literal: true

class SyncPackageDetailsJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(package_id)
    package = Package.find package_id
    package.update(PackageDetailsService.call(package))
  end
end
