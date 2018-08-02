class Subscriber < ApplicationRecord
    validates :number, presence: true, uniqueness: true

    def whatsapp_subscriber?
        number.start_with?("whatsapp:")
    end
end
