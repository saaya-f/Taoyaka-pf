require "rails_helper"

RSpec.describe "Relationshipモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user){ FactoryBot.create(:user) }
    let(:other_user){ FactoryBot.create(:user) }
    let(:relationship){ user.active_relationships.build(followed_id: other_user.id) }
    
    context "リレーションシップのテスト" do
      it "リレーションシップが有効であること" do
        expect(relationship).to be_valid
      end
    end
    
    context "存在性のテスト" do
      it "フォローしている" do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end
      it "フォローされている" do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
  # describe "アソシエーションのテスト" do
  #   it { should respond_to(:follwer) }
  #   it { should respond_to(:follwed) }
  #   it "followメソッドはフォローしているユーザーを返すこと" do
  #     expect(active.follower).to  eq user
  #   end
  #   it "followerメソッドはフォローされているユーザーを返すこと" do
  #     expect(active.followed).to eq other_user
  #   end
  # end
end