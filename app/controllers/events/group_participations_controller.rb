#  Copyright (c) 2019-2020, Schweizer Blasmusikverband. This file is part of
#  hitobito_sbv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sbv.

class Events::GroupParticipationsController < CrudController
  self.nesting = [Group, Event]
  self.permitted_attrs = [
    :music_style,
    :music_type,
    :music_level,
    :parade_music,
    :group_id,
    :joint_participation,
    :secondary_group_id,
    :secondary_group_is_primary,
    :preferred_play_day_1,
    :preferred_play_day_2,
    :terms_accepted
  ]

  decorates :event

  skip_authorize_resource
  skip_authorization_check

  before_action :participating_group, only: [:new, :edit]
  around_save :update_state_machine

  def update
    super(location: edit_group_event_group_participation_path(@group, @event, entry))
  end

  private_class_method

  def self.model_class
    Event::GroupParticipation
  end

  private

  def update_state_machine
    yield.tap do |result|
      entry.progress_for(participating_group || entry.group) if result
    end
  end

  def participating_group
    @participating_group ||= Group.find_by(id: params['participating_group'])
  end
end
