# frozen_string_literal: true

#  Copyright (c) 2020, Schweizer Blasmusikverband. This file is part of
#  hitobito_sbv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sbv.

module Export::Tabular::Groups
  class LohnsummenList < List
    def attributes
      %w[name buv_lohnsumme nbuv_lohnsumme]
    end
  end
end
