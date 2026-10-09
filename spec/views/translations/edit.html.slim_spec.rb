require 'rails_helper'

RSpec.describe "translations/edit", type: :view do
  let(:translation) {
    Translation.create!(
      translation_key_id: 1,
      locale: "MyString",
      value: "MyText",
      state: "MyString",
      source: "MyString"
    )
  }

  before(:each) do
    assign(:translation, translation)
  end

  it "renders the edit translation form" do
    render

    assert_select "form[action=?][method=?]", translation_path(translation), "post" do

      assert_select "input[name=?]", "translation[translation_key_id]"

      assert_select "input[name=?]", "translation[locale]"

      assert_select "textarea[name=?]", "translation[value]"

      assert_select "input[name=?]", "translation[state]"

      assert_select "input[name=?]", "translation[source]"
    end
  end
end
