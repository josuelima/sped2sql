# -*- encoding: utf-8 -*-
require 'csv'

module SPED2SQL
  module Layout
    class Mapa
   
      def self.carrega!(fonte)
        mapa = {}
        CSV.foreach(fonte, col_sep: '|') do |row|
          linha = row.clone
          linha.delete_if { |x| x.nil? }
          mapa[linha[0]] = linha[1..-1].map { |x| x.to_sym }
        end
        mapa
      end

    end
  end
end