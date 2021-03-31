# frozen_string_literal: true

require "rails_helper"

RSpec.describe DebianFileParserService, type: :service do
  subject { described_class.call(file_text) }

  describe ".call" do
    context "when file_text has one entry" do
      let(:file_text) do
        <<~FILE_TEXT
          name: XML
          version: 1.0.0
        FILE_TEXT
      end

      it "returns the user" do
        expect(subject).to eq([{ "name" => "XML", "version" => "1.0.0" }])
      end
    end

    context "when file_text has multiple entry" do
      let(:file_text) do
        <<~FILE_TEXT
          name: XML
          version: 1.0.0
          #{'          '}
          name: JAVA
          version: 1.8.6
        FILE_TEXT
      end

      it "returns the user" do
        expect(subject).to eq([
                                { "name" => "XML", "version" => "1.0.0" },
                                { "name" => "JAVA", "version" => "1.8.6" },
                              ])
      end
    end
  end
end
