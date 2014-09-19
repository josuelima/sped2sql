# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Layout
    describe Mapa do

      let(:mapa) { File.expand_path(File.join('spec','resources', 'mapa.txt')) }

      it "deveria carregar o layout para um mapa" do
        expect( SPED2SQL::Layout::Mapa.carrega!(mapa) ).
          to eq({
                "0000" => [:string, :string, :date, :decimal, :string],
                "0001" => [:string, :string, :decimal],
                "0002" => [:string, :string, :decimal, :string]
            })
      end

    end
  end
end