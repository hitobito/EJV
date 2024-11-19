# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module Sheet
  class Concert < Base
    self.parent_sheet = Sheet::Group

    delegate :t, to: :I18n

    def title
      t("concerts.actions_index.title")
    end
  end
end
