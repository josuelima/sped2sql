# -*- encoding: utf-8 -*-
module SPED2SQL
  module SQL
    class Parser

      attr_reader :dados, :tbl_prefix, :tbl_sufix

      HEADER  = "/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;\r\n"                   \
                "/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;\r\n"                 \
                "/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;\r\n"                   \
                "/*!40101 SET NAMES utf8 */;\r\n"                                                         \
                "/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;\r\n"                                         \
                "/*!40103 SET TIME_ZONE='+00:00' */;\r\n"                                                 \
                "/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;\r\n"                \
                "/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;\r\n" \
                "/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;\r\n"

      FOOTER  = "/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;\r\n"                         \
                "/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;\r\n"       \
                "/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;\r\n"                 \
                "/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;\r\n"   \
                "/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;\r\n" \
                "/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;\r\n"   \
                "/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;\r\n"

      def initialize(dados, options = {})
        @tbl_prefix = options[:tbl_prefix] || ""
        @tbl_sufix  = options[:tbl_sufix]  || ""
        @dados      = dados
        self
      end

      def parse!
        output = []
        inserts_agrupados.each do |registro, inserts|
          tabela = nome_tabela(registro)

          output << "LOCK TABLES `#{ tabela }` WRITE;"
          output << "/*!40000 ALTER TABLE `#{ tabela }` DISABLE KEYS */;"
          output << "INSERT INTO #{ tabela } VALUES ('',#{ inserts.join("),('',") });"
          output << "/*!40000 ALTER TABLE `#{ tabela }` ENABLE KEYS */;"
          output << "UNLOCK TABLES;"
        end

        "#{ HEADER }#{ output.join("\r\n") }\r\n#{ FOOTER }"
      end

      class << self
        def to_sql(dados, options = {})
          new(dados, options).parse!
        end
      end

      private

      def inserts_agrupados
        inserts = Hash.new { |k, v| k[v] = [] }
        dados.each { |linha| inserts[linha[0]] << linha[0..-1].map { |r| "'#{r}'" }.join(",") }
        inserts
      end

      def nome_tabela(tabela)
        "#{ @tbl_prefix }#{ tabela }#{ @tbl_sufix }"
      end
    end
  end
end