module TwilioHelper

    def parse_sms(sms)

        @body = sms[:Body]&.upcase
        @from = sms[:From]

        case true
        when @body.include?("UNSUBSCRIBE")
            subscriber = Subscriber.find_by(number: @from)

            if subscriber
                unsubscribe(subscriber)
            else
                "I did not find a subscriber with this number"
            end

        when @body.include?("SUBSCRIBE")
            subscribe(@from)

        when @body.include?("STATUS")
            status
        else
            default_message
        end
            

    end

    private

    def subscribe(number)
        subscriber = Subscriber.new(number: number)
        if subscriber.save
            "The number #{number} has been subscribed to recieve alerts. Text UNSUBSCRIBE at any time to unsubscribe."
        else
            "Whoops! The number #{number} has not been saved. It might already be subscribed."
        end
    end

    def unsubscribe(subscriber)
        subscriber.destroy
        "The number #{@from} has been unsubscribed. Text SUBSCRIBE at any time to resubscribe."
    end

    def status
        Status.last.body
    end

    def default_message
        "Sorry I didn't get that. the available commands are SUBSCRIBE, UNSUBSCRIBE, and STATUS."        
    end

end
