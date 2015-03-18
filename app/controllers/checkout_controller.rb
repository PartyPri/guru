class CheckoutController < ApplicationController

	def new
	end

	def create
		# Set your secret key: remember to change this to your live secret key in production
		# See your keys here https://dashboard.stripe.com/account
		Stripe.api_key = ENV['STRIPE_SECRET_KEY']

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create the charge on Stripe's servers - this will charge the user's card
		charge = Stripe::Charge.create(
			:amount => 1100, # amount in cents, again
			:currency => "usd",
			:source => token,
			:description => "Evrystep Registration"
		)
		rescue Stripe::CardError => e
		  # The card has been declined
	end
end