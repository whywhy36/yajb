require 'rails_helper'

RSpec.describe "orgs/show", :type => :view do
  before(:each) do
    @org = assign(:org, Org.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
