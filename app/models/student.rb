class Student < ApplicationRecord
    validates :school_email, uniqueness: true
    validates :first_name, :last_name, :school_email, :major, presence: true
    has_one_attached :profile_pic
    #validates :profile_pic, presence: true
    VALID_MAJORS = ["Computer Engineering BS", "Computer Information Systems BS",
    "Computer Science BS", "Cybersecurity Major", "Data Science and Machine Learning Major"]
    validates :major, inclusion: { in: VALID_MAJORS, message: "%{value} is not a valid major"}

end
