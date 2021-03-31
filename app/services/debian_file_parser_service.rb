# frozen_string_literal: true

class DebianFileParserService < ApplicationService
  def initialize(file_text)
    @file_text = file_text
  end

  def call
    DebControl::ControlFileBase.parse file_text
  end

  private

    attr_reader :file_text
end
