require 'rails_helper'

RSpec.describe "translation_keys/edit", type: :view do
  let(:translation_key) {
    TranslationKey.create!(
      name: "MyString",
      description: "MyText",
      state: "MyString",
      game_id: 1,
      translated: false
    )
  }

  before(:each) do
    assign(:translation_key, translation_key)
  end

  it "renders the edit translation_key form" do
    render

    assert_select "form[action=?][method=?]", translation_key_path(translation_key), "post" do

      assert_select "input[name=?]", "translation_key[name]"

      assert_select "textarea[name=?]", "translation_key[description]"

      assert_select "input[name=?]", "translation_key[state]"

      assert_select "input[name=?]", "translation_key[game_id]"

      assert_select "input[name=?]", "translation_key[translated]"
    end
  end
end
