require 'rails_helper'

RSpec.describe "types/new", :type => :view do
  before(:each) do
    assign(:type, Type.new())
  end

  it "renders new type form" do
    render

    assert_select "form[action=?][method=?]", types_path, "post" do
    end
  end
end
