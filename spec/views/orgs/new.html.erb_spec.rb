require 'rails_helper'

RSpec.describe "orgs/new", :type => :view do
  before(:each) do
    assign(:org, Org.new())
  end

  it "renders new org form" do
    render

    assert_select "form[action=?][method=?]", orgs_path, "post" do
    end
  end
end
