# encoding: utf-8

#  Copyright (c) 2012-2018, TODO: Customer Name. This file is part of
#  hitobito_sbv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_sbv.

# Configure Rails Environment
load File.expand_path('../../app_root.rb', __FILE__)
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['RAILS_ENV'] = 'test'
require File.expand_path('config/environment', ENV['APP_ROOT'])
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  reset_fixture_path File.expand_path('../../spec/fixtures', __FILE__)
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

end
