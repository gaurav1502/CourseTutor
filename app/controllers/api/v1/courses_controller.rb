class Api::V1::CoursesController < ApplicationController
  # if params not present then we also handled this error in application ActionController::ParameterMissing

  def index
    # we can also use pagination here
    courses = Course.includes(:tutors)
    # two ways to render the responses for api  as_json() and serializer
    # Call serializer for required attributes only
    render json: courses, each_serializer: CourseSerializer
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: { status: true, message: I18n.t('course.created') }, status: :ok
    else
      errors = @course.errors.full_messages.join(', ')
      render json: { status: false, message: errors }, status: :unprocessable_entity
    end
  rescue StandardError
    render json: { status: false, message: 'An issue occurred with the parameters' }, status: :unprocessable_entity
  end

  private

  # Strong params for course
  def course_params
    params.require(:course).permit(:name, :code, tutors_attributes: %i[name contact_number])
  end
end
