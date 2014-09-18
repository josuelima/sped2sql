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

    it "deveria converter os dados do sped de acordo com o mapa fornecido" do
      conversor = Conversor.new(arquivo_sped, arquivo_mapa)
      conversor.converter!
      puts conversor.saida
    end

  end
end