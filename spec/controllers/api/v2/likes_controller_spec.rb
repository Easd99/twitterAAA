require 'rails_helper'

RSpec.describe Api::V2::LikesController, "#create" do

    context "When a like" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :create, params: { id: tweet.id} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["ok"])
        end
    end

    
end

RSpec.describe Api::V2::LikesController, "#show" do

    context "When a like" do
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
            expect(json_response.keys).to  match_array(["likes"])
        end
    end

    context "When a like" do
        let(:user) {create(:user, :confirmed)}
        
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :show, params: { id: 100} 
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

RSpec.describe Api::V2::LikesController, "#destroy" do

    context "When a like" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :create, params: { id: tweet.id}
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["ok"])

        end
    end
    context "When a like" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["ok"])
        end
    end

    
end    