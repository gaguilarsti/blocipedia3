class ChargesController < ApplicationController

  after_action :upgrade_account, only: [:create]

  def new
    authorize :charges, :new?

    if current_user.role == 'premium'
      flash[:alert] = "You are already a premium member."
      redirect_to root_path
    elsif current_user.role == 'admin'
      flash[:alert] = "You are already an admin so you don't need to pay."
      redirect_to root_path
    end

    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Account - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    authorize :charges, :create?

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
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
