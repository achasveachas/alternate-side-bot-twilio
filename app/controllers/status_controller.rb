class StatusController < ApplicationController
  before_action :authenticate

  def status
    @status = Status.new(status_params)


  end

  private

  def authenticate
    head 403 unless request.env['HTTP_AUTHORIZATION']&.split(" ")&.last == ENV['AUTH_CODE']
  end
end
