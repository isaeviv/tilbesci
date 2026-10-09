require 'rails_helper'

RSpec.describe "translation_keys/new", type: :view do
  before(:each) do
    assign(:translation_key, TranslationKey.new(
      name: "MyString",
      description: "MyText",
      state: "MyString",
      game_id: 1,
      translated: false
    ))
  end

  it "renders new translation_key form" do
    render

    assert_select "form[action=?][method=?]", translation_keys_path, "post" do

      assert_select "input[name=?]", "translation_key[name]"

      assert_select "textarea[name=?]", "translation_key[description]"

      assert_select "input[name=?]", "translation_key[state]"

      assert_select "input[name=?]", "translation_key[game_id]"

      assert_select "input[name=?]", "translation_key[translated]"
    end
  end
end
