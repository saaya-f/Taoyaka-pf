require "rails_helper"

RSpec.describe "Relationshipモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user){ create(:user) }
    let(:other_user){ create(:other_user) }
    let(:relationship){ build(followed_id: other_user.id) }
    
    context "" do
      it "リレーションシップが有効であること" do
        expect(relationship.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "　　モデルとの関係" do
      it "N対1になっている" do
      end
    end
  end
end