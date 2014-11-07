# -*- encoding: utf-8 -*-
require 'spec_helper'

module SPED2SQL
  module Pipeline
    describe Base do

      let(:base_obj) { Base.new }

      it { should respond_to :execute }
      it { should respond_to :<< }

      it "deveria instanciar sem tasks quando vazio" do
        expect( Base.new.tasks ).to eq([])
      end

      it "deveria instanciar com as tasks informadas" do
        expect( Base.new([::FiltroVazio, ::FiltroAdd]).tasks ).
          to eq([::FiltroVazio, ::FiltroAdd])
      end

      it "deveria adicionar novas tarefas" do
        base_obj << ::FiltroVazio
        expect( base_obj.tasks ).to eq([::FiltroVazio])

        base_obj << ::FiltroAdd
        expect( base_obj.tasks ).to eq([::FiltroVazio, ::FiltroAdd])
      end

      it "deveria mesclar novas tarefas" do
        base_obj.merge_tasks([1, 2])
        expect( base_obj.tasks ).to eq([1, 2])

        base_obj.merge_tasks([3, 4])
        expect( base_obj.tasks ).to eq([1, 2, 3, 4])

        base_obj.merge_tasks([1, 4])
        expect( base_obj.tasks ).to eq([1, 2, 3, 4])
      end

      it "deveria retornar um objeto Base apos adicionar tarefa" do
        expect( base_obj << ::FiltroAdd ).to be_a(Base)
        expect( (base_obj << ::FiltroVazio).tasks ).to eq([::FiltroAdd, ::FiltroVazio])
      end

      it "deveria adicionar novas tarefas em linha" do
        expect( base_obj.tasks ).to eq([])
        base_obj << ::FiltroVazio << ::FiltroAdd
        expect( base_obj.tasks ).to eq([::FiltroVazio, ::FiltroAdd])
      end

      it "deveria executar os filtros adicionados" do
        base_obj << FiltroVazio
        expect( base_obj.execute({total: 1}) ).to eq({total: 1})

        base_obj << FiltroAdd
        expect( base_obj.execute({total: 1}) ).to eq({total: 101})

        base_obj << FiltroAdd
        expect( base_obj.execute({total: 1}) ).to eq({total: 201})
      end

    end
  end
end