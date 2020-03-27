# frozen_string_literal: true

#  Copyright (c) 2020, Schweizer Blasmusikverband. This file is part of
#  hitobito_sbv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sbv.

require 'spec_helper'
require 'csv'

describe Export::Tabular::Groups::LohnsummenList do
  let(:data) { described_class.csv(list) }
  let(:csv) { CSV.parse(data, headers: true, col_sep: Settings.csv.separator) }

  subject { csv }

  let(:list) do
    groups(:regionalverband_mittleres_seeland)
      .descendants
      .where(type: 'Group::Verein')
  end

  its(:headers) do
    should == ['Name', 'BUV-Lohnsumme', 'NBUV-Lohnsumme']
  end

  it 'has 1 item' do
    expect(subject.size).to eq(1)
  end

  context 'first row' do
    subject { csv[0] }

    its(['Name']) { should == 'Musikgesellschaft Aarberg' }
    its(['BUV-Lohnsumme']) { should == '1337.00' }
    its(['NBUV-Lohnsumme']) { should == '42.23' }
  end
end
