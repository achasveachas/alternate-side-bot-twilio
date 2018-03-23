class Status < ApplicationRecord
    validates :body, presence: true
    after_create :notify_subscribers

    def to_speech
        self.body.gsub("#NYCASP", "New York City Alternate Side Parking")
    end

    private

    def notify_subscribers
        MessagingWorker.perform_async(self.body) if self.suspended && !self.class.second_to_last&.body&.start_with?("UPDATE")
    end

end
