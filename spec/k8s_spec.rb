require File.expand_path '../spec_helper.rb', __FILE__

describe "k8s update" do
  it "should return data about pods" do
    get '/k8s'
    last_response.body.must_include 'pods'
    last_response.body.must_include 'running'
  end

  it "should return data about rcs" do
    get '/k8s'
    last_response.body.must_include 'rcs'
  end
end
