class StatusController < ApplicationController
  before_action :authenticate

  def status
    @status = Status.new(status_params)

    if @status.save
      head 204
    else
      head 418
    end
  end

  private

  def authenticate
    head 403 unless request.env['HTTP_AUTHORIZATION']&.split(" ")&.last == ENV['AUTH_CODE']
  end

  def status_params
    params.require(:status).permit(:body, :suspended)
  end
end
