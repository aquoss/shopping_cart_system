require 'rails_helper'

RSpec.describe "OrderHistory", type: :request do
  describe "GET /order_history" do
    it "works! (now write some real specs)" do
      get order_history_path
      expect(response).to have_http_status(200)
    end
  end
end
