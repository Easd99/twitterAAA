require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe "validations" do
    #presence
    it { should validate_presence_of(:description) }
    #length
    it { should validate_length_of(:description).is_at_most(280) }
  end

  describe 'associations' do
    it { should belong_to(:user)}
    it { should have_many(:likes)}
    it { should have_one_attached(:image)}
  end

end



# RSpec.describe Tweet, type: :model do
#   pending "Pending Example"
# end