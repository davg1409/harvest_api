class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
          
  include DeviseTokenAuth::Concerns::User
  
  belongs_to :account, optional: true

  before_create :build_associated_account!

  validates_presence_of :first_name, :last_name

  delegate :tags, :chart_accounts, to: :account

  def name
    "#{first_name} #{last_name}"
  end

  protected
    def build_associated_account!
      self.build_account name: self.name
    end
end
