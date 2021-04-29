require 'rails_helper'

RSpec.describe Api::V2::FollowersController, "#index" do
    let(:userA) {create(:user, :confirmed)}    
    context "Index" do
        before do          
            token = userA.generate_jwt(userA.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :index
        end
        it "should validate user confirmed" do
            expect(userA.confirmed?).to be true
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["followers"])
        end
    end
end