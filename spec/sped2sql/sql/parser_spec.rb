# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module SQL
    describe Parser do

      let(:header)  { "/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;\r\n"                   \
                      "/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;\r\n"                 \
                      "/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;\r\n"                   \
                      "/*!40101 SET NAMES utf8 */;\r\n"                                                         \
                      "/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;\r\n"                                         \
                      "/*!40103 SET TIME_ZONE='+00:00' */;\r\n"                                                 \
                      "/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;\r\n"                \
                      "/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;\r\n" \
                      "/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;\r\n" }

      let(:footer)  { "/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;\r\n"                         \
                      "/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;\r\n"       \
                      "/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;\r\n"                 \
                      "/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;\r\n"   \
                      "/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;\r\n" \
                      "/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;\r\n"   \
                      "/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;\r\n" }

      let(:dados) { [["0000","Teste","2014-01-01","1000.50"], 
                     ["0001","Fornecedor","1","Teste"],
                     ["0001","Fornecedor 2","12","Teste 2"]] }

      it "deveria responder a to_sql" do
        expect( Parser ).to respond_to :to_sql
      end

      it "SQL deveria conter o header" do
        expect( Parser.to_sql(dados) ).to start_with(header)
      end

      it "SQL deveria conter o footer" do
        expect( Parser.to_sql(dados) ).to end_with(footer)
      end

      it "deveria converter para sql sem pre/sufixos" do
        # analisa so os inserts
        output = Parser.to_sql(dados).gsub(header, "").gsub(footer, "")
        sql = "LOCK TABLES `0000` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `0000` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO 0000 VALUES ('','0000','Teste','2014-01-01','1000.50');\r\n" \
              "/*!40000 ALTER TABLE `0000` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                      \
              "LOCK TABLES `0001` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `0001` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO 0001 VALUES ('','0001','Fornecedor','1','Teste'),"           \
              "('','0001','Fornecedor 2','12','Teste 2');\r\n"                          \
              "/*!40000 ALTER TABLE `0001` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                      \
        
        expect( output ).to eq(sql)
      end

      it "deveria converter para sql com prefixo" do
        # analisa so os inserts
        output = Parser.to_sql(dados, {tbl_prefix: "tabela_"}).gsub(header, "").gsub(footer, "")
        sql = "LOCK TABLES `tabela_0000` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `tabela_0000` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO tabela_0000 VALUES ('','0000','Teste','2014-01-01','1000.50');\r\n" \
              "/*!40000 ALTER TABLE `tabela_0000` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                             \
              "LOCK TABLES `tabela_0001` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `tabela_0001` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO tabela_0001 VALUES ('','0001','Fornecedor','1','Teste'),"           \
              "('','0001','Fornecedor 2','12','Teste 2');\r\n"                                 \
              "/*!40000 ALTER TABLE `tabela_0001` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                             \

        expect( output ).to eq(sql)
      end

      it "deveria converter para sql com sufixo" do
        # analisa so os inserts
        output = Parser.to_sql(dados, {tbl_sufix: "_tabela"}).gsub(header, "").gsub(footer, "")
        sql = "LOCK TABLES `0000_tabela` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `0000_tabela` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO 0000_tabela VALUES ('','0000','Teste','2014-01-01','1000.50');\r\n" \
              "/*!40000 ALTER TABLE `0000_tabela` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                             \
              "LOCK TABLES `0001_tabela` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `0001_tabela` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO 0001_tabela VALUES ('','0001','Fornecedor','1','Teste'),"           \
              "('','0001','Fornecedor 2','12','Teste 2');\r\n"                                 \
              "/*!40000 ALTER TABLE `0001_tabela` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                             \

        expect( output ).to eq(sql)
      end

      it "deveria converter para sql com prefixo e sufixo" do
        # analisa so os inserts
        output = Parser.to_sql(dados, {tbl_prefix: "pr_", tbl_sufix: "_su"}).gsub(header, "").gsub(footer, "")
        sql = "LOCK TABLES `pr_0000_su` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `pr_0000_su` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO pr_0000_su VALUES ('','0000','Teste','2014-01-01','1000.50');\r\n" \
              "/*!40000 ALTER TABLE `pr_0000_su` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                            \
              "LOCK TABLES `pr_0001_su` WRITE;\r\n"                                           \
              "/*!40000 ALTER TABLE `pr_0001_su` DISABLE KEYS */;\r\n"                        \
              "INSERT INTO pr_0001_su VALUES ('','0001','Fornecedor','1','Teste'),"           \
              "('','0001','Fornecedor 2','12','Teste 2');\r\n"                                \
              "/*!40000 ALTER TABLE `pr_0001_su` ENABLE KEYS */;\r\n"                         \
              "UNLOCK TABLES;\r\n"                                                            \

        expect( output ).to eq(sql)
      end

    end
  end
end