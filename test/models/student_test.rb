require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "should raise error when saving student without first name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(last_name: "Nikola", school_email: "jokic@msudenver.edu", major: "CS")
    end
  end
  test "should raise error when saving student without last name" do
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "James", school_email: "lebron@msudenver.edu", major: "Physics")
    end
  end

  test "should raise an error when email is not unique" do
    Student.create!(first_name: "Lebron", last_name: "James", school_email: "lebron@msudenver.edu", major: "Physics")
    assert_raises ActiveRecord::RecordInvalid do
      Student.create!(first_name: "Bronny", last_name: "James", school_email: "lebron@msudenver.edu", major: "Chem")
    end
  end
end