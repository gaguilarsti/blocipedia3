class ChargesController < ApplicationController

  def new

  end

  def create

    #Amount in cents
    @amount = 15_00

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Blocipedia Premium Account - #{current_user.email}',
      :currency => 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}!  You will surely regret this purchase."

    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

end
