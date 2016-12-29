class ChargesController < ApplicationController

  after_action :upgrade_account, only: [:create]

  @amount = 15_00

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Account - #{current_user.email}",
      amount: @amount
    }
  end

  def create


    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Blocipedia Premium Account - #{current_user.email}',
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}!  You will surely regret this purchase."

    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

  private

  def upgrade_account
    current_user.update_attribute(:role, 'premium')
  end

end
