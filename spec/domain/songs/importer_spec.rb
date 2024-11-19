# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

require "spec_helper"

describe Songs::Importer do
  it "puts file not found if file does not exist" do
    expect(File).to receive(:exist?).and_return(false)

    result = described_class.new("unknown.csv").compose
    expect(result).to eql "File not found"
  end

  it "should import songs correctly" do
    expect(File).to receive(:exist?).and_return(true)
    expect(CSV).to receive(:read).and_return(example_csv)

    expect do
      result = described_class.new("example.csv").compose
      expect(result).to match(/Successfully inserted 3 songs/)
    end.to change { Song.count }.by(3)

    expect(Song.find_by(title: "title1").composed_by).to eq("composer1")
    expect(Song.find_by(title: "title1").arranged_by).to eq("arrangor1")
    expect(Song.exists?(title: "title")).to be false
  end

  private

  def example_csv
    [
      ["title", "composer", "arrangor"],
      ["title1", "composer1", "arrangor1"],
      ["title2", "composer2", "arrangor2"],
      ["title3", "composer3", "arrangor3"]
    ]
  end
end
