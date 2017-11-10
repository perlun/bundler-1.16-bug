
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'bundler-bug'
  spec.version       = '0.1.0'
  spec.authors       = ['Per Lundberg']
  spec.email         = ['per.lundberg@ecraft.com']

  spec.summary       = 'Minimal gem to illustrate a potential bundler 1.16 or JRuby bug.'
  spec.description   = spec.summary

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'puma', '~> 3.9'
  spec.add_runtime_dependency 'rack', '~> 2.0'

  # Bump to 1.0.2 after the first `bundle install` to trigger the bug.
  spec.add_runtime_dependency 'rack-cors', '1.0.1'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
