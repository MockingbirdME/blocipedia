class ChargesController < ApplicationController

  def new
      @stripe_btn_data = {
        key: "#{Rails.configuration.stripe[:publishable_key]}",
        description: "Flaxipedia Membership for #{current_user.name}",
        plan: 'premium'
      }
  end

  def create
    @user = current_user
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Subscription.create(
      customer: customer.id,
      plan: 'premium',
    )
    @user.save_subscription(charge.id)
    @user.change_user_role(1)
    flash[:notice] = "#{current_user.name}, Your membership has been upgraded to premium!"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def cancel_subscription
    @user = current_user
    sub = Stripe::Subscription.retrieve(@user.subscription)
    sub.delete
    @user.delete_subscription
    @user.change_user_role(0)
    @user.cancel_privates
    flash[:notice] = "#{current_user.name}, Your premium membership has been cancled."
    redirect_to user_path(current_user)
  end
end
