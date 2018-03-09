class Status < ApplicationRecord
    validates :body, presence: true

    def to_speech
        self.body.gsub("#NYCASP", "New York City Alternate Side Parking")
    end

    def notify_subscribers
        client = Twilio::REST::Client.new

        Subscriber.all.each do |subscriber|

            client.messages.create({
                from: ENV['TWILIO_PHONE_NUMBER'],
                to: subscriber.number,
                body: self.to_speech
              })
        end
    end

end
