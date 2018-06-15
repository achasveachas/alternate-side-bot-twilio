class MessagingWorker
    include Sidekiq::Worker
   
    def perform(message)
        self.class.notify(message)
    end

    def self.notify(message)
        client = Twilio::REST::Client.new

        Subscriber.find_each do |subscriber|

            client.messages.create(
                from: ENV['TWILIO_PHONE_NUMBER'],
                to: subscriber.number,
                body: message
              )
        end
    end
end