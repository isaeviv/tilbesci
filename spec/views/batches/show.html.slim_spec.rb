require 'rails_helper'

RSpec.describe "batches/show", type: :view do
  before(:each) do
    assign(:batch, Batch.create!(
      game_id: 2,
      codename: "Codename",
      file: "File",
      state: "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Codename/)
    expect(rendered).to match(/File/)
    expect(rendered).to match(/State/)
  end
end
