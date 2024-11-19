# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module HostnamedGroups
  extend ActiveSupport::Concern

  included do
    prepend_before_action :determine_group_by_hostname
  end

  def determine_group_by_hostname
    @group ||= Group.where(hostname: request.host).first
  end
end
