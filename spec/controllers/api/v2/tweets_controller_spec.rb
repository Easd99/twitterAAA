require 'rails_helper'

RSpec.describe Api::V2::TweetsController, "#show" do
    #let(:user2) {create(:user)}
    context "When a tweet exist" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :show, params: { id: tweet.id} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
        end
    end
    context "When a tweet no exist" do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :show, params: { id: 100} 
        end
        it "should return HTTP success error" do
            expect(response).to have_http_status(404)
        end
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

RSpec.describe Api::V2::TweetsController, "#index" do
    let(:user) {create(:user, :confirmed)}
    context "Index" do
        before do
            10.times do |i|
                create(:tweet, user: user)
            end
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :index
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            
            expect(json_response.first.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
        end
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

RSpec.describe Api::V2::TweetsController, "#destroy" do
    context "When a tweet exist and is mine" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP no contend code" do
            expect(response).to have_http_status(204)
        end
        it "should be equal id and tweet_user id" do
            expect(user.id).to eq(tweet.user_id)
        end
    end
    context "When a tweet no exist" do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            delete :destroy, params: { id: 100} 
        end
        it "should return HTTP invalid code" do
            expect(response).to have_http_status(404)
        end
    end
    context "When a tweet isn't mine" do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user2)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP invalid code" do
            expect(response).to have_http_status(404)
        end
        it "not to be equal id and tweet_user id" do
            expect(user.id).not_to eq(tweet.user_id)
        end
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

RSpec.describe Api::V2::TweetsController, "#create" do

    context "When a tweet is saved with valid params with user logged in" do
        let(:user) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :create, params: {tweet: {description: "Test implementation", user_id: user.id} }
        end
        it "should be saved " do
            json_response = JSON.parse(response.body)
            expect(json_response.values[1]).to eq("Test implementation")
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
        end
        it "should less than 280 " do
            json_response = JSON.parse(response.body)
            expect(json_response.values[1].length).to be <= 280
        end
        it "should have a user " do
            json_response = JSON.parse(response.body)
            expect(json_response.values[2]).not_to be_falsy
        end
    end

    context "When a tweet have more than 280 words" do
        let(:user) {create(:user, :confirmed)}
        before do
            text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                    Praesent non ex at justo faucibus sollicitudin. Donec nec erat et est hendrerit aliquet.
                    Donec erat turpis, bibendum ac nunc eu, hendrerit ultricies massa. Curabitur condimentum 
                    leo in massa commodo interdum vel molestie in."
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :create, params: {tweet: {description: text, user_id: user.id} }
        end
        it "should less than 280 " do
            expect(response).to have_http_status(400)
        end
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