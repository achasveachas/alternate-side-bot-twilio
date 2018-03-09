class Status < ApplicationRecord
    validates :body, presence: true

    def to_speech
        self.body.gsub("#NYCASP", "New York City Alternate Side Parking")
    end
end
