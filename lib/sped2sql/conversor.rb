module SPED2SQL
  class Conversor

    attr_reader :fonte, :layout, :saida, :memoria, :mapa

    def initialize(fonte, layout, options = {})
      valida_arquivo(fonte)
      valida_arquivo(layout)
      @fonte, @layout = fonte, layout
    end

    def convert!

      @mapa = Layout::Mapa.carrega!(@layout)

    end

    private

    def valida_arquivo(file)
      raise(ArgumentError, "Arquivo inexistente: #{file}") unless File.exists?(file)
    end

  end
end