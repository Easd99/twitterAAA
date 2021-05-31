require 'rails_helper'

RSpec.describe Api::V2::MessagesController, "#create" do

    context "When a user send a message to a follower" do
        let(:user) {create(:user, :confirmed)}
        let(:userA) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            Friendship.create(user_id: userA.id, friend_user_id: user.id)
            post :create, params: { id: userA.id, message: "hola"} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["ok"])
        end
    end
    context "When a user send a message to a no Follower" do
        let(:user) {create(:user, :confirmed)}
        let(:userA) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            
            post :create, params: { id: userA.id, message: "hola"} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(400)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
    end

    context "When a user send a message to user that not exist" do
        let(:user) {create(:user, :confirmed)}
        
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            
            post :create, params: { id: 100, message: "hola"} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(404)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
    end
end