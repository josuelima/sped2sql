# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Formatters
    describe GeraHash do

      it "deveria responder a get_hash" do 
        expect(GeraHash).to respond_to :get_hash
      end

      # (sem utilidade) melhorar ou remover
      it "deveria criar hashs distintos" do
        ids = []
        1.upto(100) { ids << GeraHash.get_hash }
        expect( ids.uniq.size ).to eq 100
      end

      it "deveria gerar hashs com 36 caracts de tamanho" do
        expect( GeraHash.get_hash.length ).to eq 36
      end

    end
  end
end