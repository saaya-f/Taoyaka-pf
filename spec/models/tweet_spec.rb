require 'rails_helper'

RSpec.describe "Tweetモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    let!(:tweet) { build(:tweet, user_id: user.id) }
    
    context "titleカラム" do
      it "空欄でないこと" do
        tweet.title = ""
        expect(tweet.valid?).to eq false;
      end
      it "2文字以上であること" do
        tweet.title = Faker::Lorem.characters(number:1)
        expect(tweet.valid?).to eq false;
      end
      it "25文字以下であること" do
        tweet.title = Faker::Lorem.characters(number:26)
        expect(tweet.valid?).to eq false;
      end
    end
    context "bodyカラム" do
      it "空欄でないこと" do
        tweet.body = ""
        expect(tweet.valid?).to eq false;
      end
      it "2文字以上であること" do
        tweet.body = Faker::Lorem.characters(number:1)
        expect(tweet.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N対1になっている" do
        expect(Tweet.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Commentモデルとの関係" do
      it "N対1になっている" do
        expect(Tweet.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end