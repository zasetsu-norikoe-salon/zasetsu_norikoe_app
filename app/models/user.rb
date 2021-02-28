# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true
  validates :gender, presence: true
  validates :employment_form, presence: true
  validates :zasetsu_count, presence: true
end
