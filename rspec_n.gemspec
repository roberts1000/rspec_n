lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rspec_n/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "rspec_n"
  spec.version       = RspecN::VERSION
  spec.authors       = ["roberts1000"]
  spec.email         = ["roberts@corlewsolutions.com"]

  spec.summary       = "A ruby gem that runs RSpec N times."
  spec.description   = "A ruby gem that runs RSpec N times."
  spec.homepage      = "https://github.com/roberts1000/rspec_n"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/roberts1000/rspec_n"
    spec.metadata["changelog_uri"] = "https://github.com/roberts1000/rspec_n/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.12.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop_plus", "~> 1.0"

  spec.add_dependency "colorize", "~> 0.8.0"
  spec.add_dependency "cri", "~> 2.15.3"
end
# rubocop:enable Metrics/BlockLength
