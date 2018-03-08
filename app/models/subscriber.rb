class Subscriber < ApplicationRecord
    validates :number, presence: true, format: {with: /\A\+\d{7,15}\z/}, uniqueness: true
end
