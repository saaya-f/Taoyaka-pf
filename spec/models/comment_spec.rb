require "rails_helper"

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user){ create(:user)}
    let(:tweet){ create(:tweet, user_id: user.id)}
    let!(:comment){ build(:comment, tweet_id: tweet.id)}
    
    context "tweet_commentカラム" do
      it "空欄でないこと" do
        comment.tweet_comment = ""
        expect(comment.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N対1になっている" do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Tweetモデルとの関係" do
      it "N対1になっている" do
        expect(Comment.reflect_on_association(:tweet).macro).to eq :belongs_to
      end
    end
  end
end