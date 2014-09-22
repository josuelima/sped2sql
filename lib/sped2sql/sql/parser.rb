# -*- encoding: utf-8 -*-
module SPED2SQL
  module SQL
    class Parser

      attr_reader :dados, :tbl_prefix, :tbl_sufix

      ROW_TEMPLATE = "INSERT INTO #tbl_prefix##table##tbl_sufix# VALUES ('',#dados#);"

      def initialize(dados, options = {})
        @tbl_prefix = options[:tbl_prefix] || ""
        @tbl_sufix  = options[:tbl_sufix]  || ""
        @dados      = dados
        self
      end

      def parse!
        output = []
        @dados.each { |linha| output << formata_linha(linha) }
        output.join("\r\n")
      end

      class << self
        def to_sql(dados, options = {})
          new(dados, options).parse!
        end
      end

      private

      def formata_linha(linha)
        linha_quoted = linha[0..-1].map { |r| "'#{r}'" }.join(",")

        ROW_TEMPLATE.gsub("#tbl_prefix#", @tbl_prefix).
                     gsub("#table#", linha[0]).
                     gsub("#tbl_sufix#", @tbl_sufix).
                     gsub("#dados#", linha_quoted)
      end
    end
  end
end