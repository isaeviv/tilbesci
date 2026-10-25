require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  let(:batch) {
    Batch.create!(
      game_id: 1,
      codename: "MyString",
      file: "MyString",
      state: "MyString"
    )
  }

  before(:each) do
    assign(:batch, batch)
  end

  it "renders the edit batch form" do
    render

    assert_select "form[action=?][method=?]", batch_path(batch), "post" do

      assert_select "input[name=?]", "batch[game_id]"

      assert_select "input[name=?]", "batch[codename]"

      assert_select "input[name=?]", "batch[file]"

      assert_select "input[name=?]", "batch[state]"
    end
  end
end
