# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # FactoryBotでUserをオブジェクト化
  let(:user) { build(:user) }

  describe 'モデルバリデーション' do
    example 'メールアドレス、パスワード、名前、性別、就業形態、挫折カウントが入力されている場合、有効である' do
      expect(user).to be_valid
    end

    example 'メールアドレスが無い場合、無効である' do
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    example 'パスワードが無い場合、無効である' do
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    example '名前が無い場合、無効である' do
      user.name = ''
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    example '性別が無い場合、無効である' do
      user.gender = ''
      user.valid?
      expect(user.errors[:gender]).to include("can't be blank")
    end

    example '就業形態が無い場合、無効である' do
      user.employment_form = ''
      user.valid?
      expect(user.errors[:employment_form]).to include("can't be blank")
    end

    example '挫折カウントが無い場合、無効である' do
      user.zasetsu_count = ''
      user.valid?
      expect(user.errors[:zasetsu_count]).to include("can't be blank")
    end
  end
end
