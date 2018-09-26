#  Copyright (c) 2012-2018, Schweizer Blasmusikverband. This file is part of
#  hitobito_sbv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sbv.

class ConcertsController < SimpleCrudController
  include YearBasedPaging

  self.nesting = Group
  self.permitted_attrs = [:name, :performed_at, :year, :verein_id, :song_census_id,
                          song_counts_attributes: [
                            :id,
                            :count,
                            :song_id,
                            :year
                          ]]

  helper_method :census

  private

  def find_entry
    model_scope.includes(song_counts: :song).find(params[:id])
  end

  def list_entries
    super.includes(song_counts: :song).includes(:song_census).in(year)
  end

  def census
    SongCensus.current
  end

  def default_year
    @default_year ||= census.try(:year) || current_year
  end

  def current_year
    @current_year ||= Time.zone.today.year
  end

  def year_range
    @year_range ||= (year - 3)..(year + 1)
  end
end
