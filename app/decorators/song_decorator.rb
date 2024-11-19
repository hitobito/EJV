# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

class SongDecorator < ApplicationDecorator
  decorates :song

  def full_label
    html = content_tag(:strong, h.h(title))
    html << " "
    formatted_extension = [composed_by, arranged_by, published_by].compact_blank.join(" | ")
    html << content_tag(:span, h.h(formatted_extension), class: "muted")
    html
  end
end
