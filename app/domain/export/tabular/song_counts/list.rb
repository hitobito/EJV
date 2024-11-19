# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module Export::Tabular::SongCounts
  class List < Export::Tabular::Base
    INCLUDED_ATTRS = %w[count title composed_by arranged_by published_by suisa_id].freeze
    GROUP_ATTRS = %w[verein verein_id].freeze
    GROUP_INFO = %w[verein_with_town].freeze

    self.model_class = SongCount
    self.row_class = Export::Tabular::SongCounts::Row

    def attributes
      if multiple?
        INCLUDED_ATTRS + GROUP_INFO
      else
        INCLUDED_ATTRS + GROUP_ATTRS
      end.collect(&:to_sym)
    end

    def multiple?
      @single_verein ||=
        Concert.where(id: list.collect(&:concert_id))
          .having("count(distinct verein_id) = 1")
          .empty?
    end
  end
end
