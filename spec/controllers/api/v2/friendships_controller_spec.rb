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
            expect(response).to have_http_status(400)
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
    context "When a user try follow a user that already follow" do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            Friendship.new(user_id: user.id, friend_user_id: user2.id).save
            post :seguir, params: {id: user2.id}
        end
        it "should not be saved " do            
            expect(response).to have_http_status(400)
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
    context "When a token is invalid" do
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
RSpec.describe Api::V2::FriendshipsController, "#index" do

    context "list all users" do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :index
        end
        it "should be saved " do            
            expect(response).to have_http_status(:success)
        end
        it "should be saved " do            
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["userlist"])
        end
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end

    end 
end    
RSpec.describe Api::V2::FriendshipsController, "#destroy" do
    context "When a tweet exist and is mine" do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            Friendship.new(user_id: user.id, friend_user_id: user2.id).save
            delete :destroy, params: { id: user2.id} 
        end
        it "should return HTTP no contend code" do
            expect(response).to have_http_status(204)
        end
    end
end