# -*- encoding: utf-8 -*-
module SPED2SQL
  class Conversor < Pipeline::Base
    include Layout

    attr_reader :fonte, :template, :saida, :memoria, :db_params

    def initialize(fonte, template, options = {})
      @fonte      = fonte
      @template   = template.kind_of?(Symbol) ? 
                      Mapa.arquivo_template(template) : template
      @saida      = []
      @memoria    = {}
      @db_params  = options[:db] || {}

      valida_arquivo(@fonte)
      valida_arquivo(@template)

      tasks = if options[:tasks].kind_of?(Array)
                options[:tasks]
              elsif options[:tasks] == :vazio
                []
              else
                [Pipeline::NormalizaSQL, Pipeline::AddHash]
              end

      super(tasks)
    end

    def converter!

      mapa = Mapa.carrega!(@template)
      CSV.foreach(fonte, col_sep: '|', quote_char: '|', encoding: 'ISO-8859-1') do |row|
        
        # O primeiro e o ultimo item de uma linha no SPED sempre é nulo
        linha = row.clone[1..-2]

        # Executa o pipe
        pipe = execute({original: linha, 
                        final:    linha, 
                        mapa:     mapa[linha.first], 
                        memoria:  @memoria, 
                        saida:    @saida})


        @saida << pipe[:final]
        @memoria[linha.first] = pipe[:final]
      
      end
    end

    def to_sql
      SQL::Parser.to_sql(@saida, @db_params)
    end

    private

    def valida_arquivo(file)
      raise(ArgumentError, "Arquivo inexistente: #{file}") unless File.exists?(file)
    end

  end
end