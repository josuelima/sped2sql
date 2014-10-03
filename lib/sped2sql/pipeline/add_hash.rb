module SPED2SQL
  module Pipeline
    module AddHash
      include Formatters

      def self.call(env)
        env[:final].push(GeraHash.get_hash)
        env
      end

    end
  end
end
