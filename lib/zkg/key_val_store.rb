require 'active_support/core_ext/string'

module ZKG
  module KeyValStore
    class NoAdapterError < StandardError; end
    
    class << self
      def get(*key_path)
        raise NoAdapterError unless @adapter
        @adapter.get(key_path)
      end

      def load_adapter(name, opts={})
        @adapter = case name
                   when String, Symbol
                     load_adapter_by_name name, opts
                   when NilClass, FalseClass
                     load_adapter_by_name :in_memory, {}
                   when Class
                     name.new(opts)
                   end
      end

      private

      def load_adapter_by_name(name, opts)
        adapter_path = "key_val_store/#{ name }_store"
        require "zkg/#{ adapter_path }"
        klass = "ZKG::#{ adapter_path.camelize}".constantize
        klass.new(**opts.symbolize_keys)
      end
    end
  end
end
