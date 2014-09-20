# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module SQL
    describe Parser do

      let(:row_template) { "INSERT INTO #tbl_prefix##table##tbl_sufix# VALUES ('',#dados#);" }

      let(:dados) { [["0000","Teste","2014-01-01","1000.50"], 
                     ["0001","Fornecedor","1","Teste"]] }

      it "deveria responder a to_sql" do
        expect( Parser ).to respond_to :to_sql
      end

      it "deveria converter para sql sem pre/sufixos" do
        expect( Parser.to_sql(dados, {}) ).
          to eq("INSERT INTO 0000 VALUES ('','Teste','2014-01-01','1000.50');"\
                "INSERT INTO 0001 VALUES ('','Fornecedor','1','Teste');")
      end

      it "deveria converter para sql com prefixo" do
        expect( Parser.to_sql(dados, {tbl_prefix: "tabela_"}) ).
          to eq("INSERT INTO tabela_0000 VALUES ('','Teste','2014-01-01','1000.50');"\
                "INSERT INTO tabela_0001 VALUES ('','Fornecedor','1','Teste');")
      end

      it "deveria converter para sql com sufixo" do
        expect( Parser.to_sql(dados, {tbl_sufix: "_tabela"}) ).
          to eq("INSERT INTO 0000_tabela VALUES ('','Teste','2014-01-01','1000.50');"\
                "INSERT INTO 0001_tabela VALUES ('','Fornecedor','1','Teste');")
      end

      it "deveria converter para sql com prefixo e sufixo" do
        expect( Parser.to_sql(dados, {tbl_prefix: "pre_", tbl_sufix: "_su"}) ).
          to eq("INSERT INTO pre_0000_su VALUES ('','Teste','2014-01-01','1000.50');"\
                "INSERT INTO pre_0001_su VALUES ('','Fornecedor','1','Teste');")
      end

    end
  end
end