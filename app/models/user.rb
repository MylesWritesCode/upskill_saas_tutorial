class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :plan
  has_one :profile
  
  attr_accessor :stripe_card_token
  # If Pro user passes validations (email, pass, etc.) then call Stripe to request subscription with customer token.
  def save_with_subscription
    if valid?
      # Send information to Stripe with email, plan id, and card token.
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      # With customer token response from last line, saves as customer id in db.
      self.stripe_customer_token = customer.id
      save!
    end
  end
end