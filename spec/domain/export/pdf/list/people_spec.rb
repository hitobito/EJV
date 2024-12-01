# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

require "spec_helper"

describe Export::Pdf::List::People do
  subject { Export::Pdf::List.render(people, group) }

  let(:people) { group.people }
  let(:group) { groups(:jodlerklub_berna_bern) }

  let(:pdf_text) { PDF::Inspector::Text.analyze(subject).show_text.compact.join(" ") }

  it "does not render the nickname" do
    expect(pdf_text).to_not match(/mynick/)
  end

  it "renders the name of people" do
    expect(pdf_text).to match(/My Member/)
  end

  it "creates a pdf" do
    is_expected.to start_with("%PDF-1.3")
  end
end
