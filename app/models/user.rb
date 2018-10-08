# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  activation_digest :string
#  admin             :boolean          default(FALSE)
#  email             :string
#  name              :string
#  password_digest   :string
#  remember_digest   :string
#  reset_digest      :string
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  include StateOfTheNation

  has_many :microposts, dependent: :destroy
  has_many :martial_arts, class_name: "MartialArts::MartialArt", dependent: :destroy
  has_many :body_weight_records, dependent: :destroy
  has_many :lift_choices, dependent: :destroy
  has_many :cardio_choices, dependent: :destroy
  has_many :lifts, through: :lift_choices
  has_many :cardios, through: :cardio_choices
  has_many :training_programs, dependent: :destroy

  has_uniquely_active :body_weight_records
  has_uniquely_active :training_programs

	attr_accessor :remember_token, :activation_token, :reset_token

	before_save :downcase_email
	before_create :create_activation_digest
  after_commit :set_default_lift_choices, on: :create
  after_commit :set_default_cardio_choices, on: :create
  after_create :send_activation_email_if_needed

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	has_secure_password

  self.per_page = 20
  def self.page_length
    self.per_page
  end


	# Returns the hash digest of the given string.
	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
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

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def resend_activation_email
    recreate_activation_digest
    send_activation_email
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    Micropost.where("user_id = ?", id)
  end

  def all_entries
    entries = []
    entries << martial_arts
    entries << lifts
    entries << cardios
    entries.flatten!

    entries.select! { |e| e.occurred_date.present? && e.occurred_time.present? }

    Entries.sort_by_occurred!(entries)
  end

  def first_name
    self.name.blank? ? "" : self.name.split(" ")[0]
  end

  def last_name
    self.name.blank? ? "" : self.name.split(" ")[1]
  end

  def current_weight
    active_body_weight_record&.weight
  end

  def update_weight(weight)
    BodyWeightRecords::Create.run!(user: self, weight: weight)
  end

	private

		# Converts email to all lower-case.
		def downcase_email
			self.email = email.downcase
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

    def recreate_activation_digest
      self.activation_token  = User.new_token
      self.update(activation_digest: User.digest(activation_token))
    end

    def send_activation_email_if_needed
      send_activation_email unless self.activated?
    end

    def set_default_lift_choices
      AddDefaultLiftChoicesWorker.perform_async(self.id)
    end

    def set_default_cardio_choices
      AddDefaultCardioChoicesWorker.perform_async(self.id)
    end

end
