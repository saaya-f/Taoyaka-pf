require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let!(:user){ build(:user) }
    
    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ""
        expect(user.valid?).to eq false;
      end
      it "2文字以上であること" do
        user.name = Faker::Lorem.characters(number:1)
        expect(user.valid?).to eq false;
      end
      it "20文字以下であること" do
        user.name = Faker::Lorem.characters(number:21)
        expect(user.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Tweetモデルとの関係" do
      it "N対1になっている" do
        expect(User.reflect_on_association(:tweets).macro).to eq :has_many
      end
    end
    context "Commentモデルとの関係" do
      it "N対1になっている" do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
  describe "relationshipモデルのバリデーション" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    before { user.follow(other_user) }
    
    context "followメソッド" do
      it "フォローが成功する" do
        expect(user.following?(other_user)).to be_truthy
      end
    end
    context "followersメソッド" do
      it "succeeds" do
        expect(other_user.followers.include?(user)).to be_truthy
      end
    end
    context "unfollowメソッド" do
      it "フォロー解除が成功する" do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsy
      end
    end
  end
end