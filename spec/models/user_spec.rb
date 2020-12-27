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
  end
end