class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

#  def index
 #   @students = Student.all
  #end

  # GET /students or /students.json. Search based on major
  def index
    @search_params = params[:search] || {}  # Ensure @search_params is a hash
    
    # Start with an empty relation, so no students are shown initially
    @students = Student.none
  
    # Display students only if search parameters are present or "Show All" is clicked
    if @search_params.present?
      @students = Student.all
  
      # Filter by major
      if @search_params[:major].present?
        @students = @students.where(major: @search_params[:major])
      end
  
      # Filter by graduation date
      if @search_params[:graduation_date_filter].present? && @search_params[:graduation_date].present?
        date = Date.parse(@search_params[:graduation_date])
        if @search_params[:graduation_date_filter] == 'before'
          @students = @students.where('graduation_date < ?', date)
        elsif @search_params[:graduation_date_filter] == 'after'
          @students = @students.where('graduation_date > ?', date)
        end
      end
    elsif params[:show_all]  # If "Show All" is clicked
      @students = Student.all
    end
  end  
  
  def show
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :graduation_date, :profile_pic)
    end
end