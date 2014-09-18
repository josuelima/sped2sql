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
  gem.description  = %q{sped2sql recebe um arquivo SPED (ou qualquer outro CSV com pipes) juntamente com seu layout em CSV e devolve um arquivo com Inserts SQL}
  gem.license      = "MIT"
  gem.homepage     = "https://github.com/josuelima/sped2sql"

  gem.files        = `git ls-files`.split("\n")
  gem.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end