# -*- encoding: utf-8 -*-
module SPED2SQL
  class Conversor
    include Layout
    include Formatters

    attr_reader :fonte, :layout, :saida, :memoria, :mapa, :proc

    def initialize(fonte, layout, options = {})
      valida_arquivo(fonte)
      valida_arquivo(layout)
      @fonte, @layout  = fonte, layout
      @saida, @memoria = [], {}
    end

    def converter!

      mapa = Mapa.carrega!(@layout)

      CSV.foreach(fonte, col_sep: '|', quote_char: '|', encoding: 'ISO-8859-1') do |row|

        # o primeiro e o ultimo item de uma linha no SPED sempre é nulo
        linha = row.clone[1..-2].zip(mapa[row[1]]).map { |dado, tipo| StringConverter.converter(dado, tipo) }

        @saida << linha
        @memoria[linha.first] = linha

      end
    end

    private

    def valida_arquivo(file)
      raise(ArgumentError, "Arquivo inexistente: #{file}") unless File.exists?(file)
    end

  end
end