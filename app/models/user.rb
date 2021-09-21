class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # roles for the multiple users in the app.
  enum role: [:admin, :user]
end

