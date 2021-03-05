# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 性別(未回答: 0, 男性: 1, 女性: 2, その他: 9)
  enumerize :gender, in: { not_known: 0, male: 1, female: 2, other: 9 }, default: :not_known

  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true
  validates :gender, presence: true
  validates :employment_form, presence: true
  validates :zasetsu_count, presence: true
end
