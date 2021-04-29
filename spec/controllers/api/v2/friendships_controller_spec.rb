require 'rails_helper'

RSpec.describe Api::V2::FriendshipsController, "#seguir" do

    context "When a friendship is saved " do
        let(:user) {create(:user, :confirmed)}
        let(:user2) {create(:user, :confirmed)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "Bearer #{token}"
            post :seguir, params: {id: user2.id}
        end
        it "should be saved " do 
            byebug
            expect(response).to have_http_status(:success)
        end
 
    end
end