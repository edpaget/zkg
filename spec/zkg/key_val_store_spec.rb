require 'zkg/key_val_store'

RSpec.describe ZKG::KeyValStore do

  describe "::get" do
    context "when no adapter is loaded" do
      it 'should raise a NoAdapterError' do
        expect do
          ZKG::KeyValStore.get("a", "key", "at_path")
        end.to raise_error(ZKG::KeyValStore::NoAdapterError)
      end
    end

    context "when an adpter has been loaded" do
      let(:adapter) { double({ get: 'returned!'}) }

      it 'should call the adapters get method' do
        ZKG::KeyValStore.instance_variable_set(:@adapter, adapter)
        expect(adapter).to receive(:get).with(["a", "key", "at_path"])
        ZKG::KeyValStore.get("a", "key", "at_path")
        ZKG::KeyValStore.instance_variable_set(:@adapter, nil)
      end
    end
  end

  describe "::load_adapter" do
    context "when passed a string or symbol" do
      it 'should load a predefined adapter class' do
        ZKG::KeyValStore.load_adapter("in_memory")
        expect(ZKG::KeyValStore.instance_variable_get(:@adapter)).to be_a(ZKG::KeyValStore::InMemoryStore)
      end
    end

    context "when passed nil or false" do
      it 'should load the in memory adapter' do
        ZKG::KeyValStore.load_adapter(nil)
        expect(ZKG::KeyValStore.instance_variable_get(:@adapter)).to be_a(ZKG::KeyValStore::InMemoryStore)
      end
    end

    context "when passed a class" do
      it "should instantiate the class with any options" do
        klass = Class.new
        expect(klass).to receive(:new).with(test: true, test1: false)
        ZKG::KeyValStore.load_adapter(klass, test: true, test1: false)
      end
    end
  end
end
