class MessagingWorker
    include Sidekiq::Worker
   
    def perform(message)
        client = Twilio::REST::Client.new

        Subscriber.all.each do |subscriber|

            client.messages.create({
                from: ENV['TWILIO_PHONE_NUMBER'],
                to: subscriber.number,
                body: message
              })
        end
    end
end