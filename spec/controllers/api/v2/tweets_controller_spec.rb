require 'rails_helper'

RSpec.describe Api::V2::TweetsController, "#show" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    #let(:user2) {create(:user)}
    context "When a tweet exist" do
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
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :show, params: { id: 100} 
        end
        it "should return HTTP success error" do
            expect(response).to have_http_status(404)
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
        it "should validate user confirmed" do
            expect(user.confirmed?).to be true
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.first.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
        end
    end
end

RSpec.describe Api::V2::TweetsController, "#destroy" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    context "When a tweet exist" do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP no contend code" do
            expect(response).to have_http_status(204)
        end
    end
end



