# SPED2SQL

[![Code Climate](https://codeclimate.com/github/josuelima/sped2sql.png)](https://codeclimate.com/github/josuelima/sped2sql)
[![Build Status](https://travis-ci.org/josuelima/sped2sql.svg?branch=master)](https://travis-ci.org/josuelima/sped2sql)
[![Test Coverage](https://codeclimate.com/github/josuelima/sped2sql/badges/coverage.svg)](https://codeclimate.com/github/josuelima/sped2sql)

** SPED2SQL is a RubyGem to convert SPED tax data files into SQL. SPED2SQL reads the SPED file and matches it against a template in order to convert the data into its corresponding SQL format. You can also make it extensible by creating as many custom parsers as you want and attach it to the reading process **

SPED2SQL é uma RubyGem que converte arquivos SPED para arquivos SQL prontos para serem inseridos no banco de dados (caso precise criar as tabelas do SPED, de uma olhada nesse outro repositório: [SPED Schema](https://github.com/josuelima/sped_schema)).

Atualmente apenas o template para a EFD ICMS IPI está disponibilizado, porém você pode implementar e customizar o seu próprio template (e se possível enviar de volta como contribuição).

# Instalação
```ruby
gem install sped2sql

```

# Uso

Convertendo um arquivo EFD ICMS IPI para SQL

```ruby
require 'sped2sql'

conversor = Conversor.new(caminho_arquivo_sped, :efd_icms_ipi)
conversor.converter!

# Salva o SQL em um arquivo texto
IO.write('caminho_destino_sql.sql', conversor.to_sql)
```