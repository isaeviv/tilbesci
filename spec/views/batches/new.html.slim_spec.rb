require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    @batch = Batch.new(
      game_id: 1,
      codename: "MyString",
      state: "MyString"
    )
    @batch.source_files.build
    assign(:batch, @batch)
  end

  it "renders new batch form" do
    controller.default_url_options = { locale: :ru }
    render

    assert_select "form[action=?][method=?]", batches_path(locale: :ru), "post" do

      assert_select "select[name=?]", "batch[game_id]"

      assert_select "select[name=?]", "batch[state]"
    end
  end
end
