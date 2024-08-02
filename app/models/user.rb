class User < ApplicationRecord
    before_create :create_reset_token
    before_save { self.email = email.downcase }
    has_many :articles, dependent: :destroy
    has_many :reactions, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :sent_messages, class_name: 'DirectMessage', foreign_key: 'sender_id'
    has_many :received_messages, class_name: 'DirectMessage', foreign_key: 'receiver_id'
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                      uniqueness: true,
                      length: { maximum: 105},
                      format: {with: VALID_EMAIL_REGEX}
    has_secure_password



    def create_reset_token
        self.reset_token = SecureRandom.urlsafe_base64
        self.reset_sent_at = Time.now
    end

    def reacted_to?(reactionable)
        reactions.exists?(reactionable: reactionable)
    end
end
