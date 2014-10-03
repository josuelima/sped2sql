# -*- encoding: utf-8 -*-
#
# Simples class para adicionar tarefas a serem executadas
# na leitura de cada linha do arquivo SPED
#
# Adicione qualquer modulo ou classe que responda a call
# recebendo como argumento um hash com a linha atual e a
# memoria e que devolva os mesmo no retorno.
module SPED2SQL
  module Pipeline
    class Base
      attr_accessor :tasks

      def initialize(tasks = [])
        @tasks = tasks
      end

      def <<(task)
        @tasks << task
        self
      end

      def execute(env)
        @tasks.each { |t| env = t.call(env) }
        env
      end
    end
  end
end
