require 'rails_helper'

RSpec.describe Api::V2::FriendshipsController, "#follow" do

    context "When a friendship is saved " do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :seguir, params: {id:user2.id}
        end
        it "should be saved " do            
            expect(response).to have_http_status(:success)
        end
        it "should be saved " do            
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["follow"])
        end
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end
        it "should validate user exist" do
            expect(user2.id).not_to be_falsy 
        end
 
    end
    context "When a user doesn't exist " do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :seguir, params: {id: 100}
        end
        it "should not be saved " do            
            expect(response).to have_http_status(404)
        end
        it "should be saved " do            
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end
 
    end
    context "When a user try auto follow " do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :seguir, params: {id: user.id}
        end
        it "should not be saved " do            
            expect(response).to have_http_status(404)
        end
        it "should be saved " do            
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end
        it "should validate user exist" do
            expect(user.id).not_to be_falsy 
        end
 
    end
    context "When a user try auto follow " do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            Friendship.new(user_id: user.id, friend_user_id: user2.id).save
            post :seguir, params: {id: user2.id}
        end
        it "should not be saved " do            
            expect(response).to have_http_status(404)
        end
        it "should be saved " do            
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end
        it "should validate user exist" do
            expect(user2.id).not_to be_falsy 
        end
 
    end
end    