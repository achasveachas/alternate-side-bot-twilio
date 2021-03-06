require "rails_helper"

RSpec.describe "Status request cycle", :type => :request do

    before(:each) do
        @auth_code = ENV['AUTH_CODE']
        @authorized_headers = {"Authorization": "Bearer #{@auth_code}"}
        @suspended_status = {status: {body: "Rules are suspended", suspended: true}}
        @not_suspended_status = {status: {body: "Rules are not suspended", suspended: false}}
    end

    describe "Authentication" do
   
        it "accepts authenticated requests" do
            post '/status', params: @suspended_status, headers: @authorized_headers

            expect(response.status).to eq(204)
        end

        it "does not accept unauthenticated requests" do
            post '/status', params: @suspended_status

            expect(response.status).to eq(403)
            expect(Status.last&.body).not_to eq(@suspended_status[:status][:body])
        end

    end

    describe "POST /status" do
        it "creates a new status" do
            post '/status', params: @suspended_status, headers: @authorized_headers
            expect(Status.last.body).to eq(@suspended_status[:status][:body])

            post '/status', params: @not_suspended_status, headers: @authorized_headers
            expect(Status.last.body).to eq(@not_suspended_status[:status][:body])
        end
    end

end