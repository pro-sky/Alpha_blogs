class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :article
  has_many :reactions, as: :reactionable, dependent: :destroy
  validates :content, presence: true
end
