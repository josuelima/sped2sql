require 'spec_helper'

module SPED2SQL
  module Layout
    describe Mapa do

      it "deveria carregar o layout para um mapa" do
        layout = File.expand_path(File.join('spec','resources', 'layout_pequeno.txt'))
        expect( SPED2SQL::Layout::Mapa.carrega!(layout) ).
          to eq({
                "0000" => [:string, :date, :decimal, :string],
                "0001" => [:string, :decimal],
                "0002" => [:string, :decimal, :string]
            })
      end

    end
  end
end