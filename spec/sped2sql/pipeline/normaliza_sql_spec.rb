# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Pipeline
    describe NormalizaSQL do

      it { should respond_to :call }
      
      let(:env)   { { original: ['0000','Teste','31122014','1000,50','Teste Fim'],
                      final:    ['0000','Teste','31122014','1000,50','Teste Fim'],
                      mapa:     {"0000" => ['0000','string','date','decimal','string']},
                      memoria:  {},
                      saida:    [] } }

      let(:saida) { { original: ['0000','Teste','31122014','1000,50','Teste Fim'],
                      final:    ['0000','Teste','2014-12-31','1000.50','Teste Fim'],
                      mapa:     {"0000" => ['0000','string','date','decimal','string']},
                      memoria:  {},
                      saida:    [] } }

      it "deveria converter os dados da linha de acordo com o tipo da coluna no mapa" do
        expect( NormalizaSQL.call(env) ).to eq(saida)
      end

    end
  end
end