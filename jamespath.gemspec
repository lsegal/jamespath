require File.join(File.dirname(__FILE__), 'lib', 'jamespath', 'version')

Gem::Specification.new do |spec|
  spec.name          = 'jamespath'
  spec.version       = Jamespath::VERSION
  spec.summary       = 'Implements JMESpath declarative object searching.'
  spec.description   = 'Like XPath, but for JSON and other structured objects.'
  spec.author        = 'Loren Segal and Trevor Rowe'
  spec.homepage      = 'http://github.com/lsegal/jamespath'
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^test/})
end
