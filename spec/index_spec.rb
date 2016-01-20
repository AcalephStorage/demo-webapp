require File.expand_path '../spec_helper.rb', __FILE__

describe "landing page" do
  it "should greet with demo man's name" do
    get '/'
    last_response.body.must_include "Hi, I'm <strong>Alistair</strong>!"
  end
end
