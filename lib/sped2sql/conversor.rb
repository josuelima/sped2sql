# -*- encoding: utf-8 -*-
module SPED2SQL
  class Conversor
    include Layout
    include Formatters

    attr_reader :fonte, :layout, :saida, :memoria, :mapa

    def initialize(fonte, layout, options = {})
      valida_arquivo(fonte)
      valida_arquivo(layout)
      @fonte, @layout = fonte, layout
      @saida = []
    end

    def converter!

      mapa = Mapa.carrega!(@layout)

      CSV.foreach(fonte, col_sep: '|', quote_char: '|', encoding: 'ISO-8859-1') do |row|

        ##
        # primeiro e ultimo item de uma linha no SPED
        # sempre é nulo
        linha = row.clone[1..-2]

        @saida << linha.zip(mapa[linha.first]).
          map { |dado, tipo| StringConverter.converter(dado, tipo) }

      end

    end

    private

    def valida_arquivo(file)
      raise(ArgumentError, "Arquivo inexistente: #{file}") unless File.exists?(file)
    end

  end
end