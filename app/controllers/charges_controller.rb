class ChargesController < ApplicationController

  def new
      @amount = 1500
      @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Flaxipedia Membership for #{current_user.name}",
        amount: @amount
      }
  end

  def create
    @amount = 1500
    @user = current_user
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charage = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Flaxipedia Membership for #{current_user.name}",
      currency: 'usd'
    )

    @user.change_user_role(1)
    flash[:notice] = "#{current_user.name}, Your account has been upgraded!"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
end
