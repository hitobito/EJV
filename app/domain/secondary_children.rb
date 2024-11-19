# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module SecondaryChildren
  def children
    primary = super
    secondary = ::Group::Verein.where(secondary_parent_id: id)
    tertiary = ::Group::Verein.where(tertiary_parent_id: id)

    ids = (primary | secondary | tertiary).map(&:id)

    Group.where(id: ids)
  end
end
