require "rails_helper"

RSpec.describe "Voice request cycle", :type => :request do

    before(:each) do
        @status = Status.create(body: "#NYCASP are in effect")
        get '/twilio/voice'

    end

   
    it "responds with a twiml containing the latest status" do

        expect(response.content_type).to eq('application/xml')
        expect(response.body).to include(@status.to_speech)

    end

    it "ensure the reply is sanitized for voice" do
        expect(response.body).not_to include("#NYCASP")
        expect(response.body).to include("New York City Alternate Side Parking")
    end

end