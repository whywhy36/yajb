require 'rails_helper'

RSpec.describe "orgs/edit", :type => :view do
  before(:each) do
    @org = assign(:org, Org.create!())
  end

  it "renders the edit org form" do
    render

    assert_select "form[action=?][method=?]", org_path(@org), "post" do
    end
  end
end
