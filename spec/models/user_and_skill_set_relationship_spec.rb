# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserAndSkillSetRelationship, type: :model do
  # FactoryBotでUserAndSkillSetRelationshipをオブジェクト化
  let(:user_and_skill_set_relationship) { build(:user_and_skill_set_relationship) }

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
