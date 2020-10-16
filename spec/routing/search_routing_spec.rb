require "rails_helper"

RSpec.describe SearchController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/search").to route_to("search#index")
    end

    it "routes to #show" do
      expect(get: "/search/1").to route_to("search#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/search").to route_to("search#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/search/1").to route_to("search#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/search/1").to route_to("search#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/search/1").to route_to("searches#destroy", id: "1")
    end
  end
end
