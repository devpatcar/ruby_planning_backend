# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password123'

    trait :admin do
      admin true
    end
  end
end
