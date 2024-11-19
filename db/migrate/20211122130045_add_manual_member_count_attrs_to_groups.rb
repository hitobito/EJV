# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.


class AddManualMemberCountAttrsToGroups < ActiveRecord::Migration[6.0]
  def up
    add_column :groups, :manual_member_count, :integer, default: 0
    add_column :groups, :manually_counted_members, :boolean, default: false, null: false
  end
end
