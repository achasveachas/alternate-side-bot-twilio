class Subscriber < ApplicationRecord
    validates :number, presence: true, uniqueness: true

    def whatsapp_subscriber?
        true
    end
end
