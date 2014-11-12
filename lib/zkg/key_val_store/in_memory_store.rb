module ZKG
  module KeyValStore
    class InMemoryStore
      attr_reader :seperator, :store
      
      def initialize(opts={})
        @store = Hash.new
        @seperator = "_" 
      end

      def get(key_path)
        key = key_path.join(seperator)
        @store.fetch key
      rescue KeyError
        raise KeyNotFoundError
      end
    end
  end
end
