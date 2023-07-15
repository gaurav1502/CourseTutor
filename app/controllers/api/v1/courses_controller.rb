class Api::V1::CoursesController < ApplicationController
  # if params not present then we also handled this error in application ActionController::ParameterMissing
  def index
    # we can also use pagination here
    courses = Course.includes(:tutors)
    course_data = courses.map do |course|
      {
        name: course.name,
        code: course.code,
        tutors: course.tutors.map { |tutor| { name: tutor.name, contact_number: tutor.contact_number } }
      }
    end
    render json: { data: course_data }
  end

  def create

    @course = Course.new(course_params)
    if @course.save
      render json: { status: true, message: I18n.t('course.created') }, status: :ok
    else
      errors = @course.errors.full_messages.join(',')
      # if error then response will status - false and message
      render json: { status: false, message: errors }, status: :unprocessable_entity
    end
  end

  private
  # Strong params for course
  def course_params
    params.require(:course)
          .permit(:name, :code,
            tutors_attributes: %i[name contact_number]
                )
  end
end
