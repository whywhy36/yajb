require 'rails_helper'

RSpec.describe "orgs/index", :type => :view do
  before(:each) do
    assign(:orgs, [
      Org.create!(),
      Org.create!()
    ])
  end

  it "renders a list of orgs" do
    render
  end
end
