require 'rails_helper'

RSpec.describe "translations/new", type: :view do
  before(:each) do
    assign(:translation, Translation.new(
      translation_key_id: 1,
      locale: "MyString",
      value: "MyText",
      state: "MyString",
      source: "MyString"
    ))
  end

  it "renders new translation form" do
    render

    assert_select "form[action=?][method=?]", translations_path, "post" do

      assert_select "input[name=?]", "translation[translation_key_id]"

      assert_select "input[name=?]", "translation[locale]"

      assert_select "textarea[name=?]", "translation[value]"

      assert_select "input[name=?]", "translation[state]"

      assert_select "input[name=?]", "translation[source]"
    end
  end
end
