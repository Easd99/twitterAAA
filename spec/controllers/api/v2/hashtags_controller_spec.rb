require 'rails_helper'

RSpec.describe Api::V2::HashtagsController, "#index" do

    context "When a like" do
        let(:user) {create(:user, :confirmed)}
        let(:tweet) {create(:tweet, user: user)}
        let(:tweet2) {create(:tweet, :invalid, user: user)}

        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            get :index, params: { hashtag: "#hola"} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["tweets"])
        end
    end

    
end    
