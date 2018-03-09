class TwilioController < ApplicationController
  def sms
    response = helpers.parse_sms(params)

    text = Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: response
    end

    render xml: text.to_s
  end

  def voice

    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(Status.last.to_speech)
    end

    render xml: response.to_s
  end
end
