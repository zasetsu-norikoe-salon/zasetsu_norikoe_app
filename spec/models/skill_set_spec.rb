# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SkillSet, type: :model do
  # FactoryBotでSkillSetをオブジェクト化
  let(:skill_set) { build(:skill_set) }

  describe 'モデルバリデーション' do
    it '名前が入力されている場合、有効である' do
      expect(skill_set).to be_valid
    end

    it '名前が未入力の場合、無効である' do
      skill_set.name = ''
      skill_set.valid?
      expect(skill_set.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end
  end

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

    context 'UserAndSkillSetRelationshipモデルとの関係' do
      let(:target) { :user_and_skill_set_relationships }

      it 'has_manyである' do
        expect(association.macro).to eq :has_many
      end
    end
  end

  describe 'Userと紐付いているSkillSet' do
    let!(:skill_set) { create(:skill_set, :with_users) }

    context 'SkillSetが削除された時' do
      it '紐付くUserAndSkillSetRelationshipも削除される' do
        expect { skill_set.destroy }.to change(UserAndSkillSetRelationship, :count).by(-1)
      end
    end
  end
end
