module TwilioHelper

    def parse_sms(sms)

        body = sms[:Body]&.upcase
        from = sms[:From]

        case true
        when body.include?("UNSUBSCRIBE")

        when body.include?("SUBSCRIBE")
            subscriber = Subscriber.new(number: from)
            if subscriber.save
                "#The number #{from} has been subscribed to recieve alerts. Text UNSUBSCRIBE at any time to unsubscribe."
            else
                "The number #{from} has not been saved."
            end

        when body.include?("STATUS")

        else

        end
            

    end

    private

end
