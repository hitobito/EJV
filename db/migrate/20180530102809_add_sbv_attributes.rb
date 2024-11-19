# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.


class AddSbvAttributes < ActiveRecord::Migration[4.2]
  def change
    add_column :groups, :vereinssitz, :string
    add_column :groups, :founding_year, :integer
    add_column :groups, :correspondence_language, :string, limit: 5
    add_column :groups, :besetzung, :string
    add_column :groups, :klasse, :string
    add_column :groups, :unterhaltungsmusik, :string
    add_column :groups, :subventionen, :string
    add_column :groups, :reported_members , :integer

    add_column :people, :profession, :string
    add_column :people, :correspondence_language, :string, limit: 5

    Group.reset_column_information
  end
end
