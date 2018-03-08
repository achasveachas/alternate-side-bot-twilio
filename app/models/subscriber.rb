class Subscriber < ApplicationRecord
    validates :number, presence: true, format: {with: /\A\+\d{7,15}\z/}
end
