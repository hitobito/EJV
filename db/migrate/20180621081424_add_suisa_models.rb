# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.


class AddSuisaModels < ActiveRecord::Migration[4.2]

  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.string :composed_by, null: false
      t.string :arranged_by
      t.string :published_by
    end

    create_table :song_counts do |t|
      t.belongs_to :song, null: false

      t.belongs_to :verein, null: false
      t.belongs_to :mitgliederverband, index: true
      t.belongs_to :regionalverband, index: true

      t.belongs_to :song_census

      t.integer :year, null: false
      t.integer :count, default: 1, null: false
    end

    create_table :song_censuses do |t|
      t.integer :year, null: false, index: :unique
      t.date    :start_at
      t.date    :finish_at
    end
  end

end
