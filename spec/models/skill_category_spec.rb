# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SkillCategory, type: :model do
  # FactoryBotでSkillCategoryをオブジェクト化
  let(:skill_category) { build(:skill_category) }

  describe 'アソシーエション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとの関係' do
      let(:target) { :users }

      it 'has_manyである' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'UserAndSkillCategoryRelationshipモデルとの関係' do
      let(:target) { :user_and_skill_category_relationships }

      it 'has_manyである' do
        expect(association.macro).to eq :has_many
      end
    end
  end

  describe 'Userと紐付いているSkillCategory' do
    let!(:skill_category) { create(:skill_category, :with_users) }

    context 'SkillCategoryが削除された時' do
      it '紐付くUserAndSkillCategoryRelationshipも削除される' do
        expect { skill_category.destroy }.to change(UserAndSkillCategoryRelationship, :count).by(-1)
      end
    end
  end
end
