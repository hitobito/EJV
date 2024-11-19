# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module Ejv::Sheet::Event
  extend ActiveSupport::Concern

  included do
    tab "events.group_participations.list",
      :group_event_group_participations_path,
      {if: lambda do |view, *args|
        _group, event = args
        event.type == "Event::Festival" && view.can?(:edit, event)
      end}
  end
end
