require 'rails_helper'

RSpec.describe Api::V2::FollowersController, "#index" do   
    context "Index" do
        let(:userA) {create(:user, :confirmed)} 
        let(:userB) {create(:user, :confirmed)} 

        before do          
            token = userA.generate_jwt(userA.jti)
            Friendship.new(user_id: userB.id, friend_user_id: userA.id).save
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