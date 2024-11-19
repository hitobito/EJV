# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

# this is used by Export::Tabular::GroupParticipations::Row as well
module GroupParticipationsFormatHelper
  def format_music_style(entry)
    music_i18n_option(:music_style, entry.music_style).first
  end

  def format_music_type(entry)
    music_i18n_option(:music_type, entry.music_type).first
  end

  def format_parade_music(entry)
    music_i18n_option(:music_type, entry.parade_music).first
  end

  def format_music_level(entry)
    music_i18n_option(:music_level, entry.music_level).first
  end

  private

  def group_participation_scope
    model_key = Event::GroupParticipation.name.underscore
    {scope: "activerecord.attributes.#{model_key}"}
  end

  def music_i18n_option(kind, value)
    [
      I18n.t("#{kind.to_s.pluralize}.#{value}", **group_participation_scope),
      value
    ]
  end
end
