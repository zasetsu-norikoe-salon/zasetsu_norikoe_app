# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SkillSet, type: :model do
  # FactoryBotでSkillSetをオブジェクト化
  let(:skill_set) { build(:skill_set) }

  describe 'アソシーエション' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userモデルとの関係' do
      let(:target) { :users}
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
end
