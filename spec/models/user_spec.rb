# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # FactoryBotでUserをオブジェクト化
  let(:user) { build(:user) }

  describe 'モデルバリデーション' do
    it 'メールアドレス、パスワード、名前、性別、就業形態、挫折カウントが入力されている場合、有効である' do
      expect(user).to be_valid
    end

    it 'メールアドレスが無い場合、無効である' do
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it 'パスワードが無い場合、無効である' do
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
    end

    it '名前が無い場合、無効である' do
      user.name = ''
      user.valid?
      expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it '性別が無い場合、無効である' do
      user.gender = ''
      user.valid?
      expect(user.errors[:gender]).to include(I18n.t('errors.messages.blank'))
    end

    it '就業形態が無い場合、無効である' do
      user.employment_type = ''
      user.valid?
      expect(user.errors[:employment_type]).to include(I18n.t('errors.messages.blank'))
    end

    it '挫折カウントが無い場合、無効である' do
      user.zasetsu_count = ''
      user.valid?
      expect(user.errors[:zasetsu_count]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
