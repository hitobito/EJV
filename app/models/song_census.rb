# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

# == Schema Information
#
# Table name: song_censuses
#
#  id        :integer          not null, primary key
#  year      :integer          not null
#  start_at  :date
#  finish_at :date
#

class SongCensus < ActiveRecord::Base
  after_initialize :set_defaults

  has_many :concerts, dependent: :destroy
  has_many :song_counts, through: :concerts, dependent: :destroy

  validates_by_schema

  validates :year, uniqueness: true
  validates :start_at,
    presence: true,
    timeliness: {type: :date, allow_blank: true, before: Date.new(10_000, 1, 1)}
  validates :finish_at,
    timeliness: {type: :date, allow_blank: true, after: :start_at}

  class << self
    # The last census defined (may be the current one)
    def last
      order(:start_at).last
    end

    # The currently active census
    def current
      where(start_at: ..Time.zone.today).order(:start_at).last
    end
  end

  def reminder_period?
    Time.zone.now > start_at && Time.zone.now < finish_at
  end

  def finished?
    finish_at.past?
  end

  def current?
    self.class.current == self
  end

  def to_s
    year
  end

  private

  def set_defaults
    return unless new_record?

    self.start_at ||= Time.zone.today
    self.finish_at ||= future_finish_at
    self.year ||= (finish_at || start_at).year
    self
  end

  def future_finish_at
    if Settings.census
      maybe_finish_at = Date.new(start_at.year,
        Settings.census.default_finish_month,
        Settings.census.default_finish_day)

      if maybe_finish_at.prev_day.past?
        Date.new(start_at.year.succ, maybe_finish_at.month, maybe_finish_at.day)
      else
        maybe_finish_at
      end
    end
  end
end
