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
        it "should less than 280 " do
            expect(Tweet.last.description.length).to be <= 280
        end
        it "should have a user " do
            expect(Tweet.last.description).not_to be_falsy
        end
    end

    context "When a tweet is not saved" do
        let(:user) {create(:user, :confirmed)}
        before do
            sign_in(user)
            text =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
            Praesent non ex at justo faucibus sollicitudin. Donec nec erat et est hendrerit aliquet.
            Donec erat turpis, bibendum ac nunc eu, hendrerit ultricies massa. Curabitur condimentum 
            leo in massa commodo interdum vel molestie in."
            post :create, params: {tweet: {description: text, user_id: 1} }
        end
        it "should redirect user to Tweet Index" do
            expect(subject).to  redirect_to(new_tweet_path)
        end
    end
 
end

RSpec.describe TweetsController, "#destroy" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    context "When a tweet exist" do
        before do            
            sign_in(user)
            delete :destroy, params: { id: tweet.id} 
        end
        it "should return HTTP no contend code" do
            expect(response).to have_http_status(302)
            
        end
    end
end

RSpec.describe TweetsController, "#index" do
    let(:user) {create(:user, :confirmed)}
    context "Index" do
        before do
            sign_in(user)
            10.times do |i|
                create(:tweet, user: user)
            end            
            get :index
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
     end
end