#storing the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  publishable_key: ENV['stripe_publishable_key'],
  secret_key: ENV['stripe_api_key']
}

# Set the app-stored secret key with stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
