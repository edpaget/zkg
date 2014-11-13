require_relative "../spec_helper"
require "zkg/app"

RSpec.describe ZKG::App do
  include TestHelpers

  before(:each)  do
    klass = described_class.class_eval do
      log_level ::Logger::ERROR
      self
    end
    
    @server = klass.run "localhost", 80808
  end

  after(:each) do
    @server.terminate if @server && @server.alive?
  end
  
  RSpec.shared_examples "an api response" do
    context "response status" do
      subject { response.code }
      
      it { is_expected.to eq(200) }
    end

    context "response headers" do
      subject { response.headers }

      it { is_expected.to include(["Content-Type", "application/json"]) }
    end

    context "response body" do
      subject { json_response }

      it { is_expected.to include(api_response_key) }
    end
  end

  describe "get projects" do
    let(:api_response_key) { "project_statistics" }
    
    before(:each) do
      get "/projects/1"
    end

    it_behaves_like "an api response"
  end

  describe "get workflow" do
    let(:api_response_key) { "workflow_statistics" }
    
    before(:each) do
      get "/workflows/1"
    end
    
    it_behaves_like "an api response"
  end
end
