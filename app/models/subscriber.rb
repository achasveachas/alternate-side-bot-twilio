class Subscriber < ApplicationRecord
    validates :number, presence: true, uniqueness: true
    validate :number_format

    def whatsapp_subscriber?
        number.start_with? "whatsapp:"
    end

    def number_format
        unless /\A\+\d{7,15}\z/.match(number) || /\Awhatsapp:\+\d{7,15}\z/.match(number)
            errors.add :number, "is the wrong format"
        end
    end
end
