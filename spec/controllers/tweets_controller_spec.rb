require 'rails_helper'

RSpec.describe TweetsController, "#create" do
   let(:user) {create(:user)}
    before do
        sign_in(user)
        post :create, params: {tweet: {description: "Test implementation", user_id: 1} }
    end
    it "should be saved " do
        expect(Tweet.last.description).to eq("Test implementation")
    end

end
