# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    sequence :name do |n|
      "name#{n}"
    end
    version { FFaker::SemVer.next }
    r_version_needed { "(>= 1.12.0)" }
    dependencies { FFaker::Lorem.phrase }
    date_and_publication { FFaker::Time.datetime }
    title { FFaker::Lorem.words }
    authors { "authors" }
    maintainers { "maintainer" }
    license { "MIT" }
  end
end
