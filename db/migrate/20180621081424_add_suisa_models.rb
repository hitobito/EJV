# encoding: utf-8

#  Copyright (c) 2012-2013, Puzzle ITC GmbH. This file is part of
#  hitobito_generic and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_generic.

class AddSuisaModels < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title, null: false, index: :unique
      t.string :composed_by, null: false
      t.string :arranged_by
      t.string :published_by
    end

    create_table :song_counts do |t|
      t.belongs_to :census, null: false
      t.belongs_to :song, null: false
      t.belongs_to :verein, null: false
      t.belongs_to :mitgliederverband_id, index: true
      t.belongs_to :regionalverband_id, index: true
      t.integer :count, default: 1, null: false
    end

    add_index :song_counts, [:census_id, :song_id, :verein_id], unique: true

    create_table :song_censuses do |t|
      t.integer :year, null: false, index: :unique
      t.date    :start_at
      t.date    :finish_at
    end

    add_column :groups, :song_census_completed, :boolean, null: false, default: false
  end
end