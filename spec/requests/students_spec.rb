require 'rails_helper'

# GET /students (index)
describe "GET /students" do
  context "when students exist" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }
    
    it "returns a successful response and displays the search form" do
      get students_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Search') # Ensure search form is rendered
    end

    it "does not display students until a search is performed" do
      get students_path
      expect(response.body).to_not include("Aaron")
    end
  end

  context "when no students exist or no search is performed" do
    it "displays a message prompting to search" do
      get students_path
      expect(response.body).to include("No students to display. Please use the search form to find students by major or graduation date, or click \"Show All\" to display all students.")
    end
  end
end

# POST /students (create)
describe "POST /students" do
  context "with valid parameters" do
    it "creates a new student and redirects" do
      expect {
        post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
      }.to change(Student, :count).by(1)
      expect(response).to have_http_status(:found)  # Expect redirect after creation
      follow_redirect!
      expect(response.body).to include("Aaron ")  # Student's details in the response
    end
  end
end

# DELETE /students/:id (destroy)
describe "DELETE /students/:id" do
  let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

  it "returns a 404 status when trying to delete a non-existent student" do
    delete "/students/9999"
    expect(response).to have_http_status(:not_found)
  end
end