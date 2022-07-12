# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         :trackable
  has_many :providers, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :comments
  has_many :active_relationships,
           class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  after_create :assign_default_role
  # attr_accessor :remember_token, :activation_token
  # before_save :downcase_email
  # before_create :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX },
  # uniqueness: true
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def self.from_omniauth(auth)
    result = User.find_or_create_by(email: auth.info.email)
    result.name = auth.info.name if result.name.nil?
    result.email = auth.info.email
    result.activated = true
    result.password = SecureRandom.urlsafe_base64 if result.password.nil?
    result.save!
    result.providers.find_or_create_by(provider: auth.provider, name: auth.info.name)
    result
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
                    following_ids: following_ids, user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
