# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAndSkillSetRelationship, type: :model do
  # FactoryBotでUserAndSkillSetRelationshipをオブジェクト化
  let(:user_and_skill_set_relationship) { build(:user_and_skill_set_relationship) }

  describe 'モデルバリデーション' do
    it 'user_id, skill_set_id, 経験値が入力されている場合、有効である' do
      expect(user_and_skill_set_relationship).to be_valid
    end

    it '経験値が未入力の場合、無効である' do
      user_and_skill_set_relationship.level = ''
      user_and_skill_set_relationship.valid?
      expect(user_and_skill_set_relationship.errors[:level]).to include(I18n.t('errors.messages.blank'))
    end
  end

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

    context 'SkillSetモデルとの関係' do
      let(:target) { :skill_set }

      it 'belongs_toである' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
