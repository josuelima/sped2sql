# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# require 'backup/win/version'

Gem::Specification.new do |gem|
  gem.name         = "sped2sql"
  gem.version      = SPED2SQL::VERSION
  gem.authors      = ["Josué Lima"]
  gem.email        = ["josuedsi@gmail.com"]
  gem.summary      = "Transforma em SQL os arquivos do SPED (EFD ICMS/IPI, ECD, EFD Contribuições)"
  gem.description  = "Transforma em SQL os arquivos do SPED (EFD ICMS/IPI, ECD, EFD Contribuições)"
  gem.license      = "MIT"
  gem.homepage     = "https://github.com/josuelima/sped2sql"

  gem.files        = `git ls-files -z`.split("\x0")
  gem.executables  = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.require_path = ["lib"]

  gem.required_ruby_version = '>= 1.9.3'
  
  gem.add_development_dependency "rspec"
end