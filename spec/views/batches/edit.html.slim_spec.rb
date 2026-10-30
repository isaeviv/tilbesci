require 'rails_helper'

RSpec.describe "batches/edit", type: :view do
  let(:game) { Game.create!(name: "Test Game") }
  let(:batch) {
    Batch.create!(
      game_id: game.id,
      codename: "MyString",
      state: "pending"
    )
  }

  before(:each) do
    assign(:batch, batch)
    batch.source_files.build
  end

  it "renders the edit batch form" do
    controller.default_url_options = { locale: :ru }
    render

    assert_select "form[action=?][method=?]", batch_path(batch, locale: :ru), "post" do

      assert_select "select[name=?]", "batch[game_id]"

      assert_select "select[name=?]", "batch[state]"
    end
  end
end
