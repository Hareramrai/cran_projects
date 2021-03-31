# frozen_string_literal: true

class Package < ApplicationRecord
  acts_as_paranoid

  validates :name, :version, presence: true
  validates :name, uniqueness: { scope: :version }
end
