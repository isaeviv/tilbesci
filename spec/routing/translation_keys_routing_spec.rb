require "rails_helper"

RSpec.describe TranslationKeysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/translation_keys").to route_to("translation_keys#index")
    end

    it "routes to #new" do
      expect(get: "/translation_keys/new").to route_to("translation_keys#new")
    end

    it "routes to #show" do
      expect(get: "/translation_keys/1").to route_to("translation_keys#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/translation_keys/1/edit").to route_to("translation_keys#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/translation_keys").to route_to("translation_keys#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/translation_keys/1").to route_to("translation_keys#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/translation_keys/1").to route_to("translation_keys#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/translation_keys/1").to route_to("translation_keys#destroy", id: "1")
    end
  end
end
