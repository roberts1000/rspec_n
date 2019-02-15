require "rspec_n/version"

require "colorize"
require "open3"

require "rspec_n/helpers/time_helpers"

require "rspec_n/runner"
require "rspec_n/run"
require "rspec_n/formatters/table_formatter"

# Setup pry for development when running "rake console". Guard against load
# errors in production (since pry is only loaded as a DEVELOPMENT dependency
# in the .gemspec)
# rubocop:disable Lint/HandleExceptions
begin
  require "pry"
rescue LoadError
end
# rubocop:enable Lint/HandleExceptions
