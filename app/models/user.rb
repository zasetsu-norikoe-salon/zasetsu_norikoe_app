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

  # 就業形態(正社員: 1, 正社員(異業種): 2, 副業: 3, フリーランス: 4, インターン: 5, 求職中: 6)
  enumerize :employment_type, in: { full_time: 1, diff_full_time: 2, side_biz: 3, freelance: 4, internship: 5, job_seeker: 6 }, default: :full_time

  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true
  validates :gender, presence: true
  validates :employment_type, presence: true
  validates :zasetsu_count, presence: true
end
