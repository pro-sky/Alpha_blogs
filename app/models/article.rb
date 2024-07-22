class Article < ApplicationRecord
    acts_as_paranoid
    belongs_to :user
    has_many :article_categories
    has_many :comments, dependent: :destroy
    has_many :reactions, as: :reactionable, dependent: :destroy
    has_many :categories, through: :article_categories
    validates :title, presence: true, uniqueness: true,length: {minimum: 6,maximum:100}
    validates :discription, presence: true,length: {minimum: 10,maximum:300}

    def self.reset_view_counts
        update_all(view_count: 0)
    end

end
