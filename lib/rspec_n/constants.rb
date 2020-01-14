module RspecN
  ALLOWED_ORDER_OPTIONS = %w[defined project rand].freeze
  DEFAULT_ITERATIONS = 10
  DEFAULT_COMMAND = 'bundle exec rspec'.freeze
  DEFAULT_RSPEC_STARTER_COMMAND = 'bin/start_rspec'.freeze
  # rubocop:disable Layout/LineLength
  DEFAULT_RAILS_COMMAND = 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=test bundle exec rake db:drop db:create db:migrate && bundle exec rspec'.freeze
  # rubocop:enable Layout/LineLength
end
