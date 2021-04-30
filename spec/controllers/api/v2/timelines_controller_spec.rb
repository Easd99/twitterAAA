require 'rails_helper'

RSpec.describe Api::V2::TimelinesController, "#index" do
    let(:userA) {create(:user, :confirmed)}
    let(:userB) {create(:user, :confirmed)}
    let(:userC) {create(:user, :confirmed)}
    context "Show Timeline" do
        before do
            2.times do |i|
                create(:tweet, user: userA)
                create(:tweet, user: userB)
                create(:tweet, user: userC)
            end
            token = userA.generate_jwt(userA.jti)
            Friendship.new(user_id: userA.id, friend_user_id: userB.id).save
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
            expect(json_response.keys).to  match_array(["timeline"])
        end
        # it "should return only 4 tweets" do
        #     json_response = JSON.parse(response.body)
        #     expect(json_response.length).to be == 4
        # end
    end
    context "Token invalido" do
        let(:userA) {create(:user, :confirmed)} 
        before do          
            token = userA.generate_jwt(userA.jti)
            jwt_payload = JWT.decode(token.split(' ')[0], Rails.application.secret_key_base).first
            User.revoke_jwt(jwt_payload, User.find(userA.id))
            request.headers["Authorization"] = "Bearer #{token}"
            get :index
        end
        it "should validate user confirmed" do
            expect(userA.confirmed?).to be true
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(401)
        end
    end
end