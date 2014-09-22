# -*- encoding: utf-8 -*-
module SPED2SQL
  module Formatters
    class GeraHash
      def self.get_hash
        SecureRandom.uuid
      end
    end
  end
end 