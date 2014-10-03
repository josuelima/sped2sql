# -*- encoding: utf-8 -*-
module SPED2SQL
  module Layout
    TEMPLATE_PATH = File.expand_path('../../../../templates', __FILE__)

    class Mapa
      ##
      # Carrega um mapa (arquivo csv) para um hash
      #
      # Esse mapa define o tipo de dado em cada campo de
      # um registro do SPED e eh utilizado para fazer a
      # normalizacao do dado vindo do arquivo SPED na hora
      # de inserir no banco de dados
      #
      # Exemplo de um mapa:
      #
      # - Para um arquivo SPED:
      #   |0001|Dados aleatorios|Dados aleatorios|
      #   |0001|Dados do Fornecedor|01012014|1150,00|
      #
      # - O mapa deveria ser:
      #   |0001|string|string|string|
      #   |0175|string|string|date|decimal|
      #
      # O hash final sera:
      # { "0001" => [:string, :string], "0175" => [:string, :date, :decimal] }

      def self.carrega!(fonte)
        mapa = {}

        CSV.foreach(fonte, col_sep: '|') do |row|
          linha = row.clone.compact
          mapa[linha[0]] = linha[1..-1].map(&:to_sym)
        end

        mapa
      end

      def self.arquivo_template(tipo)
        case tipo
        when :efd_icms_ipi
          File.join(TEMPLATE_PATH, 'efd_icms_ipi.txt')
        else
          fail(ArgumentError, "Template inexistente: #{tipo}")
        end
      end
    end
  end
end
