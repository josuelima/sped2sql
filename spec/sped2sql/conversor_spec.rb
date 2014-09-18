require 'spec_helper'

module SPED2SQL
  describe Conversor do

    before { @arquivo_valido = File.expand_path(File.join('spec','resources', 'csv.txt')) }

    it "deveria validar se o arquivo sped existe ou nao" do
      expect { Conversor.new('???', @arquivo_valido) }.
        to raise_error(ArgumentError, "Arquivo inexistente: ???")
      

      expect { Conversor.new(@arquivo_valido, @arquivo_valido) }.
        not_to raise_error
    end

    it "deveria validar se o arquivo de layout existe ou nao" do
      expect { Conversor.new(@arquivo_valido, '???') }.
        to raise_error(ArgumentError, "Arquivo inexistente: ???")
    end


  end
end