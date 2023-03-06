require_relative "lib/mailbluster/version"

Gem::Specification.new do |spec|
  spec.name = "mailbluster"
  spec.version = Mailbluster::VERSION
  spec.authors = ["Tanay Lakhani"]
  spec.email = ["tpl253@nyu.edu"]

  spec.summary = "A Ruby wrapper for Mailbluster API"
  spec.homepage = "https://github.com/tanaylakhani/mailbluster-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.3"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/tanaylakhani/mailbluster-ruby/issues",
    "changelog_uri" => "https://github.com/tanaylakhani/mailbluster-ruby/releases",
    "source_code_uri" => "https://github.com/tanaylakhani/mailbluster-ruby",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(["LICENSE.txt", "README.md", "{exe,lib}/**/*"]).
               reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 2"
end
