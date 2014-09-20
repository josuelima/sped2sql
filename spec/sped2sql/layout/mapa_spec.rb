# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Layout
    describe Mapa do

      let(:mapa) { File.expand_path(File.join('spec','resources', 'mapa.txt')) }

      it "deveria carregar o layout para um hash" do
        expect( Mapa.carrega!(mapa) ).
          to eq({
                "0000" => [:string, :string, :date, :decimal, :string],
                "0001" => [:string, :string, :decimal],
                "0002" => [:string, :string, :decimal, :string]
            })
      end

      it "deveria ter uma pasta valida para os tempaltes" do
        expect( File.exists?(Layout::TEMPLATE_PATH) ).to be true
      end

      it "deveria responder a arquivo_template" do
        expect( Mapa ).to respond_to :arquivo_template
      end

      it "deveria retornar arquivos validos para os templates default" do
        [:efd_icms_ipi].each do |tipo|
          expect( File.exists?(Mapa.arquivo_template(tipo)) ).to be true
        end
      end

      it "deveria lançar excessao quando template default nao existe" do
        expect { Mapa.arquivo_template(:fake_template) }.
          to raise_error(ArgumentError, "Template inexistente: #{:fake_template.to_s}")
      end

    end
  end
end