# frozen_string_literal: true

#  Copyright (c) 2012-2024, Eidgenössischer Jodlerverband. This file is part of
#  hitobito_ejv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_ejv.

module Ejv
  module Export::Pdf::List
    module People
      def person_row(person)
        [
          person.full_name, # person_name without nickname
          address(person),
          person.email,
          phone_numbers(person, %w[Privat]),
          phone_numbers(person, %w[Mobil])
        ]
      end
    end
  end
end
