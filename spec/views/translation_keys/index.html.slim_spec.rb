require 'rails_helper'

RSpec.describe "translation_keys/index", type: :view do
  before(:each) do
    assign(:translation_keys, [
      TranslationKey.create!(
        name: "Name",
        description: "MyText",
        state: "State",
        game_id: 2,
        translated: false
      ),
      TranslationKey.create!(
        name: "Name",
        description: "MyText",
        state: "State",
        game_id: 2,
        translated: false
      )
    ])
  end

  it "renders a list of translation_keys" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
