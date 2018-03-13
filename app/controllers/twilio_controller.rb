class TwilioController < ApplicationController
  before_action :authorize_request

  def sms
    response = helpers.parse_sms(params)

    text = Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: response
    end

    render xml: text.to_s
  end

  def voice

    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say Status.last.to_speech, voice: 'alice'
      r.pause length: 1
      r.say "To subscribe to get SMS messages whenever rules are suspended, text 'sunscribe' to this number", voice: 'alice'
    end

    render xml: response.to_s
  end

  private

  def authorize_request

    if params[:AccountSid] != ENV['TWILIO_ACCOUNT_SID']

      text = Twilio::TwiML::MessagingResponse.new do |r|
        r.message body: "There was a problem authorizing this SMS"
      end
  
      render xml: text.to_s
    end
    
  end
end
