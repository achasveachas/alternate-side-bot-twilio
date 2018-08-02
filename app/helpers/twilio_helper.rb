module TwilioHelper

    def parse_sms(sms)

        @body = sms[:Body]&.upcase
        @from = sms[:From]
        @pretty_from = @from.sub("whatsapp:", "")

        case true
        when @body.include?("UNSUBSCRIBE")
            unsubscribe

        when @body.include?("SUBSCRIBE")
            subscribe

        when @body.include?("STATUS")
            status

        else
            default_message
            
        end
            

    end

    private

    def subscribe
        subscriber = Subscriber.new(number: @from)

        if subscriber.save
            "The number #{@pretty_from} has been subscribed to receive alerts. Text UNSUBSCRIBE at any time to unsubscribe."
        else
            "Whoops! The number #{@pretty_from} has not been saved. It might already be subscribed."
        end
    end

    def unsubscribe
        @subscriber = Subscriber.find_by(number: @from)

        if @subscriber
            @subscriber.destroy
            "The number #{@pretty_from} has been unsubscribed. Text SUBSCRIBE at any time to resubscribe."
        else
            "Sorry, I did not find a subscriber with the number #{@pretty_from}."
        end

    end

    def status
        Status.last.body
    end

    def default_message
        "Sorry I didn't get that. the available commands are SUBSCRIBE, UNSUBSCRIBE, and STATUS."        
    end

end
