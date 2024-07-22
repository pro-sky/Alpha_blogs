class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  validates :user_id, presence: true
end
