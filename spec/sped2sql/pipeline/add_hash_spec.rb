# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Pipeline
    describe AddHash do

      before do
        @hash = Formatters::GeraHash.get_hash
        allow(Formatters::GeraHash).to receive(:get_hash).and_return(@hash)
      end

      let(:env)   { { original: ['0000','Teste','31122014','1000,50','Teste Fim'],
                      final:    ['0000','Teste','31122014','1000,50','Teste Fim'],
                      mapa:     ['0000','string','date','decimal','string'],
                      memoria:  {},
                      saida:    [] } }

      let(:saida) { { original: ['0000','Teste','31122014','1000,50','Teste Fim'],
                      final:    ['0000','Teste','31122014','1000,50','Teste Fim', @hash],
                      mapa:     ['0000','string','date','decimal','string'],
                      memoria:  {},
                      saida:    [] } }

      it { should respond_to :call }

      it "deveria converter os dados da linha de acordo com o tipo da coluna no mapa" do
        expect( AddHash.call(env) ).to eq(saida)
      end

    end
  end
end