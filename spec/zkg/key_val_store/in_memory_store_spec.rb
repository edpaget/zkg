require 'zkg/key_val_store/in_memory_store'

RSpec.describe ZKG::KeyValStore::InMemoryStore do
  describe "#get" do
    context "key exists" do
      it 'should return the value at the key' do
        path = ["asdf", "asdf", "asdf"]
        subject.set(path, "test value")
        expect(subject.get(path)).to eq("test value")
      end
    end

    context "key does not exist" do
      it 'should raise a KeyNotFoundError' do
        expect do
          subject.get(%w(this isn't real))
        end.to raise_error(ZKG::KeyValStore::KeyNotFoundError)
      end
    end
  end
end
