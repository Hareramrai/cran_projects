# frozen_string_literal: true

class CronJobs::SyncAllPackageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform
    SyncPackageListService.call
  end
end
