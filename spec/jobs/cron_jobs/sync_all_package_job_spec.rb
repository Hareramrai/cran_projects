# frozen_string_literal: true

require "rails_helper"

RSpec.describe CronJobs::SyncAllPackageJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later }

  it "queues the job" do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it "executes perform" do
    expect(SyncPackageListService).to receive(:call)
    perform_enqueued_jobs { job }
  end
end
