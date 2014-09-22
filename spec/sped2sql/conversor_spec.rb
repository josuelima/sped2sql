# -*- encoding: utf-8 -*-
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

    it "deveria instanciar com as tasks default" do
      conversor = Conversor.new(arquivo_sped, arquivo_mapa)
      expect( conversor.tasks ).to eq([Pipeline::NormalizaSQL, Pipeline::AddHash])
    end

    it "deveria instaciar com o template informado" do
      conversor = Conversor.new(arquivo_sped, :efd_icms_ipi)
      expect( conversor.template ).to eq( File.expand_path("templates/efd_icms_ipi.txt") )
    end

    it "deveriar validar se o template informado é valido" do
      expect { Conversor.new(arquivo_sped, :fake_template) }.
        to raise_error(ArgumentError, "Template inexistente: #{:fake_template.to_s}")
    end

    it "deveria instanciar sem tasks quando informado" do
      conversor = Conversor.new(arquivo_sped, arquivo_mapa, {tasks: :vazio})
      expect( conversor.tasks ).to eq([])
    end

    it "deveria instanciar apenas com as tasks informadas" do
      conversor = Conversor.new(arquivo_sped, arquivo_mapa, {tasks: [::FiltroVazio, ::FiltroAdd]})
      expect( conversor.tasks ).to eq([::FiltroVazio, ::FiltroAdd])
    end

    describe 'Conversão' do

      it "deveria não modificar a saída se nenhum pipe for passado" do
        conversor = Conversor.new(arquivo_sped, arquivo_mapa, {tasks: :vazio})
        conversor.converter!
        expect( conversor.saida ).to eq([['0000','Teste','31122014','1000,50','Teste Fim'],
                                         ['0001','Empresa X','1520,37'],
                                         ['0002','Fornecedor','5200537,21','Dados']])
      end

      it "deveria modificar apenas com o pipe informado" do
        conversor = Conversor.new(arquivo_sped, arquivo_mapa, {tasks: [Pipeline::NormalizaSQL]})
        conversor.converter!
        expect( conversor.saida ).to eq([['0000','Teste','2014-12-31','1000.50','Teste Fim'],
                                         ['0001','Empresa X','1520.37'],
                                         ['0002','Fornecedor','5200537.21','Dados']])
      end

      it "deveria converter utilizando os pipes default" do
        hash = Formatters::GeraHash.get_hash
        allow(Formatters::GeraHash).to receive(:get_hash).and_return(hash)

        conversor = Conversor.new(arquivo_sped, arquivo_mapa)
        conversor.converter!
        expect( conversor.saida ).to eq([['0000','Teste','2014-12-31','1000.50','Teste Fim', hash],
                                         ['0001','Empresa X','1520.37', hash],
                                         ['0002','Fornecedor','5200537.21','Dados', hash]])
      end

      it "deveria converter para sql" do
        hash = Formatters::GeraHash.get_hash
        allow(Formatters::GeraHash).to receive(:get_hash).and_return(hash)

        conversor = Conversor.new(arquivo_sped, arquivo_mapa)
        conversor.converter!
        expect( conversor.to_sql ).
          to eq("INSERT INTO 0000 VALUES ('','0000','Teste','2014-12-31','1000.50','Teste Fim','#{hash}');\r\n"\
                "INSERT INTO 0001 VALUES ('','0001','Empresa X','1520.37','#{hash}');\r\n"\
                "INSERT INTO 0002 VALUES ('','0002','Fornecedor','5200537.21','Dados','#{hash}');")
      end

    end

  end
end