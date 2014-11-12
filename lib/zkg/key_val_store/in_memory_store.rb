require 'zkg/key_val_store/errors'

module ZKG
  module KeyValStore
    class InMemoryStore
      
      def initialize(opts={})
        @store = Hash.new
        @seperator = "_" 
      end

      def get(key_path)
        @store.fetch key(key_path)
      rescue KeyError
        raise KeyNotFoundError
      end

      def set(key_path, value)
        @store[key(key_path)] = value
      end

      private

      def key(path)
        key = path.join(@seperator)
      end
    end
  end
end
