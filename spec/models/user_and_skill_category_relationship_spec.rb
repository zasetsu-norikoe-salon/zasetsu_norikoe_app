# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAndSkillCategoryRelationship, type: :model do
  # FactoryBotでUserAndSkillCategoryRelationshipをオブジェクト化
  let(:user_and_skill_category_relationship) { build(:user_and_skill_category_relationship) }

  describe 'アソシーエション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }

      it 'belongs_toである' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'SkillCategoryモデルとの関係' do
      let(:target) { :skill_category }

      it 'belongs_toである' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
