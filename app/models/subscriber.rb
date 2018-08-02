class Subscriber < ApplicationRecord
    validates :number, presence: true, uniqueness: true
end
