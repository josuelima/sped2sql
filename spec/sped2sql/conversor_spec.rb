require 'spec_helper'

module SPED2SQL
  describe Conversor do

    let(:arquivo_sped) { File.expand_path(File.join('spec','resources', 'sped.txt')) }
    let(:arquivo_mapa) { File.expand_path(File.join('spec','resources', 'mapa.txt')) }

    it "deveria validar se o arquivo sped existe ou nao" do
      expect { Conversor.new('???', arquivo_mapa) }.
        to raise_error(ArgumentError, "Arquivo inexistente: ???")
      

      expect { Conversor.new(arquivo_sped, arquivo_mapa) }.
        not_to raise_error
    end

    it "deveria validar se o arquivo de layout existe ou nao" do
      expect { Conversor.new(arquivo_sped, '???') }.
        to raise_error(ArgumentError, "Arquivo inexistente: ???")
    end

    describe 'Conversão' do

      let(:conversor) { Conversor.new(arquivo_sped, arquivo_mapa) }

      it "deveria converter sped de acordo com o mapa" do
        conversor.converter!
      end

      it "deveria converter sped de acordo com o mapa (passando um bloco)" do

      end

    end

  end
end