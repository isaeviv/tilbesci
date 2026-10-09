require 'rails_helper'

RSpec.describe "translation_keys/show", type: :view do
  before(:each) do
    assign(:translation_key, TranslationKey.create!(
      name: "Name",
      description: "MyText",
      state: "State",
      game_id: 2,
      translated: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end
