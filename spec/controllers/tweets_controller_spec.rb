require 'rails_helper'

RSpec.describe TweetsController, "#create" do

    context "When a tweet is saved with valid params with user logged in" do
        let(:user) {create(:user, :confirmed)}
        before do
            sign_in(user)
            post :create, params: {tweet: {description: "Test implementation", user_id: 1} }
        end
        it "should be saved " do
            expect(Tweet.last.description).to eq("Test implementation")
        end
        it "should redirect user to Tweet Index" do
            expect(subject).to  redirect_to(tweets_path)
        end
    end

    # context "When a tweet exist" do
    #     let(:user) {create(:user)}
    #     before do
    #         sign_in(user)
    #         get :show, params: { id: tweet.id} 
    #     end
        
    #     it "should return HTTP success code" do
    #         expect(response).to have_http_status(:success)
    #     end

    #     it "should return Tweet in JSON body" do
    #         json_responde = JSON.parse(response.body)
    #         expect(json_responde.keys).to  match_array(["id","description","user_id","created_at","updated_at"])
    #     end
    # end


end
