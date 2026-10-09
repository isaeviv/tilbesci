require 'rails_helper'

RSpec.describe "translations/index", type: :view do
  before(:each) do
    assign(:translations, [
      Translation.create!(
        translation_key_id: 2,
        locale: "Locale",
        value: "MyText",
        state: "State",
        source: "Source"
      ),
      Translation.create!(
        translation_key_id: 2,
        locale: "Locale",
        value: "MyText",
        state: "State",
        source: "Source"
      )
    ])
  end

  it "renders a list of translations" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Locale".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Source".to_s), count: 2
  end
end
