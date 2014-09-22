# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sped2sql/version"

Gem::Specification.new do |gem|
  gem.name         = "sped2sql"
  gem.version      = SPED2SQL::VERSION
  gem.platform     = Gem::Platform::RUBY
  gem.authors      = ["Josué Lima"]
  gem.email        = ["josuedsi@gmail.com"]
  gem.summary      = %q{Transforma em SQL os arquivos do SPED (EFD ICMS/IPI, ECD, EFD Contribuições}
  gem.description  = %q{Transforma um arquivo SPED em um arquivo SQL pronto para ser importado para MySQL}
  gem.license      = "MIT"
  gem.homepage     = "https://github.com/josuelima/sped2sql"

  gem.files        = `git ls-files`.split("\n")
  gem.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency "rake", "~> 10.3.0"
  gem.add_development_dependency "rspec", "~> 3.0.0"
end