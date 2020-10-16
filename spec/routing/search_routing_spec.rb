require "rails_helper"

RSpec.describe SearchController, type: :routing do
  describe "routing" do

    it "routes for root" do
      expect(get: "/").to route_to("search#about")
    end

    it "routes for search" do
      expect(get: "/search").to route_to("search#search")
    end
  end
end
