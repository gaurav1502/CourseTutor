# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - "3.1.2"

* Rails version - 7.0.6

System dependencies
* Configuration
  Run bundle install
  rails new course-final --api -d postgresql -- which create ruby api project
  Create serializer -rails generate serializer Tutor
  For creating the course and tutor Please use below API link https://red-space-112403.postman.co/workspace/My-Workspace~8635891e-f8b9-434f-8b9b-593373b3bc7c/request/16950636-55e2a382-ccfc-4f5c-acdd-612430d3335b?ctx=documentation
*
  {
    "course":
      { 
        "name": "JAVA",
        "code": "CSE11",
        "tutors_attributes":
        [
          { "name": "test tutor", "contact_number": "7654321461" },
          { "name": "test tutor 2", "contact_number": "3276542345"}
        ] 
      }
  }

* Responses

  { "status": true, "message": "Course created successfully." }
  
  { "status": false, "message": "Tutors contact number has already been taken, Code has already been taken" }

* Database
  * Postgres
* Database initialization rails db:create, rails db:migrate*

*How to run the test suite
  * rspec ./spec/requests/api/v1/courses_spec.rb for specific controller/model
directly run rspec command
...
