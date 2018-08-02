class Subscriber < ApplicationRecord
    validates :number, presence: true, uniqueness: true, format: {with: /\A(whatsapp:)?\+\d{7,15}\z/}

    def whatsapp_subscriber?
        number.start_with? "whatsapp:"
    end
    
end
