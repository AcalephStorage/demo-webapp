require File.expand_path '../spec_helper.rb', __FILE__

describe "landing page" do
  it "demo man's image should exist" do
    visit '/'
    pic = page.find(:css, '#demo-pic')['src']
    assert File.exists?(DemoMan.public_folder + pic)
  end
end
