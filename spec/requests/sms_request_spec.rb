require "rails_helper"

RSpec.describe "SMS request cycle", :type => :request do

    @subscribe_params = {From: "+1234567890", Body: "SUBSCRIBE"}
    @unsubscribe_params = {From: "+1234567890", Body: "UNSUBSCRIBE"}
    @status_params = {From: "+1234567890", Body: "STATUS"}
    @default_params = {From: "+1234567890", Body: "UNDEFINED"}


    describe "SUBSCRIBE" do

        it "sending an SMS with 'SUBSCRIBE' adds a subscriber" do
            post '/twilio/sms', params: @subscribe_params

            expect(Subscriber.last.number).to eq(@subscribe_params[:From])
        end

        it "sending an SMS with 'SUBSCRIBE' from an existing number does not add a subscriber" do
            post '/twilio/sms', params: @subscribe_params
            post '/twilio/sms', params: @subscribe_params

            expect(Subscriber.where(number: @subscribe_params[:From].count)).to eq(1)
        end

    end

    describe "UNSUBSCRIBE" do

        it "sending an SMS with 'UNSUBSCRIBE' unsubscribes that subscriber" do
            post '/twilio/sms', params: @subscribe_params
            post '/twilio/sms', params: @unsubscribe_params

            expect(Subscriber.find_by([number: @subscribe_params[:From]])).to be(false)
        end

    end

    describe "STATUS" do

        xit "sending an SMS with 'STATUS' sends a reply with the latest status" do
            status1 = Status.create(body: "This is the first status")
            status2 = Status.create(body: "This is the second status")
            post '/twilio/sms', params: @status_params

            expect(response.body).to have_selector("Message")
            expect(response.body).to have_selector("Message")
        end

    end

    describe "DEFAULT" do

        it "sending an SMS with without a recognized command returns a helpful message listing the available commands" do
            post '/twilio/sms', params: @default_params

            expect(response.body).to include(" SUBSCRIBE", "UNSUBSCRIBE", "STATUS")

        end

    end


end