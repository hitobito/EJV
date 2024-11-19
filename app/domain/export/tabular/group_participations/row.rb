# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module Export::Tabular::GroupParticipations
  class Row < Export::Tabular::Row
    include GroupParticipationsFormatHelper

    self.dynamic_attributes = {
      /^group/ => :group_attribute,
      /^music/ => :participation_format_attribute,
      /^parade_music$/ => :participation_format_attribute
    }

    def group_id
      entry.group.to_s
    end

    def secondary_group_id
      entry.secondary_group.to_s
    end

    def group_member_count
      entry.group.recognized_members
    end

    def group_dirigent
      entry.group.roles.where(type: "Group::Verein::Conductor")
        .first.try(:person)&.to_s
    end

    def group_contact
      entry.group.contact
    end

    private

    def participation_format_attribute(attr)
      return nil if entry.read_attribute(attr).blank? # :music_style

      format_participation_attr = :"format_#{attr}" # :format_music_style
      send(format_participation_attr, entry) # format_music_style(entry)
    end

    def group_attribute(attr)
      return send(attr) if respond_to?(attr) # :group_email

      group_attr = attr.to_s.delete_prefix("group_").to_sym # :email
      entry.group.send(group_attr) # entry.group.email
    end
  end
end
