require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    assign(:batch, Batch.new(
      game_id: 1,
      codename: "MyString",
      file: "MyString",
      state: "MyString"
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", batches_path, "post" do

      assert_select "input[name=?]", "batch[game_id]"

      assert_select "input[name=?]", "batch[codename]"

      assert_select "input[name=?]", "batch[file]"

      assert_select "input[name=?]", "batch[state]"
    end
  end
end
