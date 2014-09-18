module SPED2SQL
  module Formatters
    class StringConverter
        class << self

          def converter(subject, tipo)
            return "" unless valid_subject?(subject)
            self.send(tipo, subject)
          end

          def string(subject)
            subject.gsub(/['"\\\x0]/,'\\\\\0')
          end

          def date(subject)
            [subject[4..7], subject[2..3], subject[0..1]].join("-")
          end

          def decimal(subject)
            subject.gsub(/\./, '').gsub(/,/, '.')
          end

          private

            def method_missing(m, *dados)
              dados[0]
            end

            def valid_subject?(subject)
              !(subject.nil? || subject == "")
            end

        end
    end
  end
end 