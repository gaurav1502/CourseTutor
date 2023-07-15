require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/courses"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/api/v1/courses", params: { course: { name: "Sample Course", code: "ABC123" } }
      expect(response).to have_http_status(:success)
    end
  end

  let(:course) { FactoryBot.create(:course) }
  let(:tutor) { FactoryBot.create(:tutor, course: course) }
  let(:tutor2) { FactoryBot.create(:tutor, course: course) } # create another tutor for the same course

  describe '#index' do

    def get_all_courses
      get "/api/v1/courses"
    end

    it 'should return all courses' do
      course
      tutor
      tutor2
      get_all_courses
      response_body = JSON.parse(response.body)
      expect(response.code).to eq('200')
      expect(response_body.count).to eq(1)
      expect(response_body[0]['tutors'].count).to eq(2)
    end
  end

  describe '#create' do
    before(:each) do
      post "/api/v1/courses", params: params
    end

    context 'when params are valid' do
      let(:params) do
        {
          course: {
            name: 'Course 1',
            code: '502',
            tutors_attributes: [
              { name: 'Tutor 1', contact_number: '8989891234' },
              { name: 'Tutor 2', contact_number: '8989891231' }
            ]
          }
        }
      end

      it 'should create a course' do
        expect(Course.count).to eq(1)
      end
      it 'should create tutors for the course' do
        expect(Tutor.count).to eq(2)
      end
      it 'should return a success message' do
        response_body = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(response_body['message']).to eq('Course created successfully.')
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          course: {
                  name: nil,
                  code: '502'
          }
        }
      end

      it 'should not create a course' do
        expect(Course.count).to eq(0)
      end

      it 'should return an error message' do
        response_body = JSON.parse(response.body)
        expect(response.code).to eq('422')
        expect(response_body['message']).to eq("Name can't be blank")
      end
    end
  end
end
