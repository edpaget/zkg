require 'angelo'
require 'mustermann'
require 'angelo/mustermann'

class ZKG < Angelo::Base
  include Angelo::Mustermann

  get "/users/:id" do
  end

  get "/projects/:id" do
  end

  get "/workflows/:id" do
  end

  get "/subject_sets/:id" do
  end
end
