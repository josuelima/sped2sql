# -*- encoding: utf-8 -*-
module SPED2SQL
  module Formatters
    class StringConverter
      class << self
        def converter(subject, tipo)
          return '' unless valid_subject?(subject)
          send(tipo, subject)
        end

        def string(subject)
          subject.gsub(/['"\\\x0]/, '\\\\\0')
        end

        def date(subject)
          Date.parse("#{subject[4..7]}-#{subject[2..3]}-#{subject[0..1]}").to_s
        end

        def decimal(subject)
          # O formato para decimal no SPED eh sempre #.###,##
          subject.gsub(/\./, '').gsub(/,/, '.')
        end

        private

        def method_missing(_, *dados)
          dados[0]
        end

        def valid_subject?(subject)
          !(subject.nil? || subject == '')
        end
      end
    end
  end
end
