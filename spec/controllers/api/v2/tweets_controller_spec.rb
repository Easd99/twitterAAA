require 'rails_helper'

RSpec.describe Api::V2::TweetsController, "#show" do

    let(:user) {create(:user)}
    let(:tweet) {create(:tweet, user: user)}

    context "When a task exist" do
        
        before do
            token = user.generate_jwt()
            request.headers["Authorization"] = "Bearer #{token}"
            get :show, params: { id: tweet.id} 
        end
        
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end

        it "should return Tweet in JSON body" do
            json_responde = JSON.parse(response.body)
            expect(json_responde.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
        end
    end

end

