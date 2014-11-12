module ZKG
  module KeyValStore
    class << self
      def get(*key_path)
        raise NoAdapterError unless @adapter
        @adapter.get(key_path)
      end

      def load_adpater(name, opts={})
        @adapter = case name
                   when String, Symbol
                     load_adapter_by_name name.to_s, opts
                   when NilClass, FalseClass
                     load_adapter_by_name :in_memory, {}
                   when Class
                     new.new(opts)
                   end
      end

      private

      def load_adapter_by_Name(name, opts)
        "KeyValStore::#{ name.camelize }".constantize.new(**opts.symbolize_keys)
      end
    end
  end
