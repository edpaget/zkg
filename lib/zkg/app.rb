require 'angelo'
require 'mustermann'
require 'angelo/mustermann'

module ZKG
  class App < Angelo::Base
    include Angelo::Mustermann

    content_type :json
    
    get "/users/:id" do
    end

    get "/projects/:id" do
      { "project_statistics" => [{ "id" => 1}] }
    end

    get "/workflows/:id" do
      { "workflow_statistics" => [{ "id" => 1}] }
    end

    get "/subject_sets/:id" do
    end
  end
end
