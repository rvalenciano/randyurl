require 'rails_helper'

RSpec.describe Url, :type => :model do
  subject {
    described_class.new(url: "http://someurl/something/over/the/rainbow", 
    minified_url: "http://randyurl.com/j7ve58y")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a url" do
    subject.url = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a minified url" do
    subject.minified_url = nil
    expect(subject).to_not be_valid
  end
end
