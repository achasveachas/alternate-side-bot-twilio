require "rails_helper"

RSpec.describe "SMS request cycle", :type => :request do

    before(:each) do
        @account_sid = ENV['TWILIO_ACCOUNT_SID']
        @unauthorized_request = {From: "+1234567890", Body: "UNAUTHORIZED", AccountSid: "wrong-sid"}
        @subscribe_params = {From: "whatsapp:+1234567890", Body: "SUBSCRIBE", AccountSid: @account_sid}
        @unsubscribe_params = {From: "whatsapp:+1234567890", Body: "UNSUBSCRIBE", AccountSid: @account_sid}
        @status_params = {From: "+1234567890", Body: "STATUS", AccountSid: @account_sid}
        @default_params = {From: "+1234567890", Body: "UNDEFINED", AccountSid: @account_sid}
    end

    describe "Authorization" do
        it "does not allow unauthorized requests through" do
            post '/twilio/sms', params: @unauthorized_request

            expect(response.body).to include("There was a problem authorizing this SMS")
        end
    end

    describe "SUBSCRIBE" do

        before(:each) do
            post '/twilio/sms', params: @subscribe_params
        end

        it "sending an SMS with 'SUBSCRIBE' adds a subscriber" do

            expect(Subscriber.last.number).to eq(@subscribe_params[:From])
        end

        it "sending an SMS with 'SUBSCRIBE' from an existing number does not add a subscriber" do

            post '/twilio/sms', params: @subscribe_params

            expect(Subscriber.where(number: @subscribe_params[:From]).count).to eq(1)
        end

        context "return message" do

        
            it "replies with a helpful message" do
    
                expect(response.content_type).to eq('application/xml')
                expect(response.body).to include("subscribed")
    
            end

            it "scrubs the whatsapp substring from the number for whatsapp subscribers" do
                expect(response.body).not_to include("whatsapp")
            end

        end


    end

    describe "UNSUBSCRIBE" do

        before(:each) do
            post '/twilio/sms', params: @subscribe_params
            post '/twilio/sms', params: @unsubscribe_params
        end

        it "sending an SMS with 'UNSUBSCRIBE' unsubscribes that subscriber" do
            expect(Subscriber.find_by(number: @subscribe_params[:From])).to be_nil
        end

        context "return message" do

            it "replies with a helpful message" do
                expect(response.content_type).to eq('application/xml')
                expect(response.body).to include("unsubscribed")
            end

            it "scrubs the whatsapp substring from the number for whatsapp subscribers" do
                expect(response.body).not_to include("whatsapp")
            end

        end

    end

    describe "STATUS" do

        it "sending an SMS with 'STATUS' sends a reply with the latest status" do
            status1 = Status.create(body: "This is the first status")
            status2 = Status.create(body: "This is the second status")
            post '/twilio/sms', params: @status_params

            expect(response.content_type).to eq('application/xml')
            expect(response.body).to include(status2.body)
            expect(response.body).not_to include(status1.body)
        end

    end

    describe "DEFAULT" do

        it "sending an SMS with without a recognized command returns a helpful message listing the available commands" do
            post '/twilio/sms', params: @default_params

            expect(response.content_type).to eq('application/xml')
            expect(response.body).to include(" SUBSCRIBE", "UNSUBSCRIBE", "STATUS")

        end

    end


end