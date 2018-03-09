require "rails_helper"

RSpec.describe "Voice request cycle", :type => :request do

    before(:each) {@status = Status.create(body: "Test Status")}

   
    it "responds with a twiml containing the latest status" do
        get '/twilio/voice'

        expect(response.content_type).to eq('application/xml')
        expect(response.body).to include(@status.body)

    end

end