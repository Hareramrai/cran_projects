# frozen_string_literal: true

require "rails_helper"

RSpec.describe SyncPackageDetailsJob, type: :job do
  include ActiveJob::TestHelper

  let(:package) { create(:package) }
  let(:name) { "new package name" }

  subject(:job) { described_class.perform_later(package.id) }

  it "queues the job" do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it "executes perform" do
    expect(PackageDetailsService).to receive(:call).with(package).and_return(name: name)
    perform_enqueued_jobs { job }
    expect(package.reload.name).to eq(name)
  end
end
