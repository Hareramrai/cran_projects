# frozen_string_literal: true

require "open-uri"

class ExtractTextFromFileUrlService < ApplicationService
  def initialize(file_url:, is_tar_file: false, from_file: nil)
    @file_url = file_url
    @is_tar_file = is_tar_file
    @from_file = from_file
  end

  def call
    if is_tar_file
      GZippedTar::Reader.new(file_resource.read).read from_file
    else
      Zlib::GzipReader
        .new(file_resource)
        .read
    end
  end

  private

    attr_reader :file_url, :is_tar_file, :from_file

    def file_resource
      @file_resource ||= URI.parse(file_url).open
    end
end
