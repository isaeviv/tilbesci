require 'rails_helper'

RSpec.describe "translations/show", type: :view do
  before(:each) do
    assign(:translation, Translation.create!(
      translation_key_id: 2,
      locale: "Locale",
      value: "MyText",
      state: "State",
      source: "Source"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Locale/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Source/)
  end
end
