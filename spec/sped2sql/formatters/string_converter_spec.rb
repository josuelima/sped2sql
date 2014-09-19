# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Formatters
    describe StringConverter do

      let(:conversores) { [:string, :date, :decimal] }

      it "deveria responder aos conversores" do
        conversores.each do |conversor|
          expect( StringConverter ).to respond_to(conversor)
        end
      end

      it "deveria retornar uma string vazia para dados nulos ou vazios" do
        conversores.each do |conversor|
          expect( StringConverter.converter("", conversor)  ).to eq ""
          expect( StringConverter.converter(nil, conversor) ).to eq ""
        end
      end

      it "deveria retornar a string" do
        expect( StringConverter.converter("123", :string) ).to eq "123"
      end

      it "deveria 'escapar' strings quem contem apostrofos" do
        expect( StringConverter.converter("test'e'a", :string) ).to eq "test\\'e\\'a"
      end

      it "deveria retornar o mesmo dado se o conversor nao existir" do
        expect( StringConverter.conveter("010101", :no_converter) ).to eq "010101"
      end

      it "deveria formatar a string para data" do
        expect( StringConverter.converter("01102014", :date) ).to eq "2014-10-01"
      end

      it "deveria formatar a string para decimal" do
        expect( StringConverter.converter("100,25", :decimal) ).to       eq "100.25"
        expect( StringConverter.converter("1.100,25", :decimal) ).to     eq "1100.25"
        expect( StringConverter.converter("1.000.000,25", :decimal) ).to eq "1000000.25"
      end

    end
  end
end