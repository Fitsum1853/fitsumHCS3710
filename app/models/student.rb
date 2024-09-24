class Student < ApplicationRecord
    validates :school_email, uniqueness: true
    validates :first_name, :last_name, :school_email, :major, presence: true
    has_one_attached :profile_pic
    validates :profile_pic, presence: true
end
