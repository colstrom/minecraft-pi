Gem::Specification.new do |gem|
  gem.name        = 'minecraft-pi'
  gem.version     = `git describe --tags --abbrev=0`.chomp
  gem.licenses    = 'MIT'
  gem.authors     = ['Chris Olstrom']
  gem.email       = 'chris@olstrom.com'
  gem.homepage    = 'https://github.com/colstrom/minecraft-pi'
  gem.summary     = 'Control Minecraft Pi Edition from Ruby'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'contracts', '~> 0.14', '>= 0.14.0'
end
