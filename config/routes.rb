Rails.application.routes.draw do
  post 'twilio/sms'

  get 'twilio/voice'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
