require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    assign(:batches, [
      Batch.create!(
        game_id: 2,
        codename: "Codename",
        file: "File",
        state: "State"
      ),
      Batch.create!(
        game_id: 2,
        codename: "Codename",
        file: "File",
        state: "State"
      )
    ])
  end

  it "renders a list of batches" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Codename".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("File".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
  end
end
