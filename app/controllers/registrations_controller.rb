class RegistrationsController < ApplicationController

  #Commented out lines requiring signin to register for Evrystyles.

  def new
    #unless user_signed_in?
    #  flash[:notice] = "You must be signed in to register for this event."
    #  redirect_to :root#error
    #end

    @registration = Registration.new
    @event = Event.find_by_id(1)
  end

  def create
    #if user_signed_in?
    @registration = Registration.new(params[:registration])
    @registration.event_id = 1
    #@user = current_user
    #@registration.user_id = @user.id

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
      #:description => @registration.user_id
    )

    if @registration.save
      flash[:notice] = "You are now registered!" #for #{@registration.event.name.find(params[:id]).first_name}!"
      redirect_to :root
    else
      render "new"
      flash[:notice] = "We're sorry, we were unable to register you."
    end
    #else
    #  flash[:notice] = "You must be signed in to register for this event."
    #  redirect_to :root #TODO Redirect to sign up page
    #end
  end

end
