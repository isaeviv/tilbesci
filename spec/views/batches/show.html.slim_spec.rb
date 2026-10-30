require 'rails_helper'

RSpec.describe "batches/show", type: :view do
  let(:game) { Game.create!(name: "Test Game") }
  
  before(:each) do
    assign(:batch, Batch.create!(
      game_id: game.id,
      codename: "Codename",
      state: "pending"
    ))
  end

  it "renders attributes in <p>" do
    controller.default_url_options = { locale: :ru }
    render
    expect(rendered).to match(/Codename/)
    expect(rendered).to match(/pending/)
  end
end
