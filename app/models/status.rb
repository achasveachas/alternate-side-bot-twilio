class Status < ApplicationRecord
    validates :body, presence: true
end
