class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :reactions, as: :reactionable, dependent: :destroy
  validates :content, presence: true
end
