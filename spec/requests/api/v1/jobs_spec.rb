# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Jobs", type: :request do
  describe "GET #index" do
    subject { get api_v1_jobs_path }

    context "when no jobs" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 jobs" do
      before { FactoryBot.create_list(:job, 10) }

      it_behaves_like "return 200 success"

      it "is expected to return all jobs" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 10

        assert_response_schema_confirm 200
      end
    end
  end

  describe "POST #create" do
    subject {
      post api_v1_jobs_path, params: params
    }

    context "when name is nil" do
      let(:params) {
        {
          job: {
            name: nil
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is blank" do
      let(:params) {
        {
          job: {
            name: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is duplicated" do
      before { FactoryBot.create(:job, name: "TestUser") }

      let(:params) {
        {
          job: {
            name: "TestUser"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is present" do
      let(:params) {
        {
          job: {
            name: "TestJob"
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to eq "TestJob"

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is nil" do
      let(:params) {
        {
          job: {
            name: Faker::Name.name,
            ancestry: nil
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq nil

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is blank" do
      let(:params) {
        {
          job: {
            name: Faker::Name.name,
            ancestry: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when ancestry with some parent Job is present" do
      let!(:parent_job) { FactoryBot.create(:job) }
      let(:params) {
        {
          job: {
            name: Faker::Name.name,
            ancestry: parent_job.id.to_s
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq parent_job.id.to_s

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry with no parent Job is present" do
      let(:params) {
        {
          job: {
            name: Faker::Name.name,
            ancestry: "1"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end
  end

  describe "PATCH #update" do
    let!(:parent_job) { FactoryBot.create(:job, name: "ParentJob") }
    let(:parent_job_2) { FactoryBot.create(:job) }
    let!(:job) { FactoryBot.create(:job, name: "TestJob", ancestry: parent_job.id.to_s) }

    subject {
      patch api_v1_job_path(job), params: params
    }

    context "when name is nil" do
      let(:params) {
        {
          job: {
            name: nil
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { job.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is blank" do
      let(:params) {
        {
          job: {
            name: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { job.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is duplicated" do
      let(:params) {
        {
          job: {
            name: "ParentJob"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { job.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is valid" do
      let(:params) {
        {
          job: {
            name: "NewName"
          }
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :name" do
        expect { subject }.to change { job.reload.name }.to("NewName")

        assert_response_schema_confirm 204
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:parent_job) { FactoryBot.create(:job) }

    subject { delete api_v1_job_path(parent_job) }

    context "when parent has no children" do
      it_behaves_like "return 204 no content"

      it "is expected to delete job" do
        expect { subject }.to change(Job, :count).by -1
        expect(parent_job.reload.deleted_at).to be_present

        assert_response_schema_confirm 204
      end
    end

    context "when parent has children" do
      before { FactoryBot.create(:job, ancestry: parent_job.id.to_s) }

      it_behaves_like "return 400 bad request"

      it "is expected to delete job" do
        expect { subject }.not_to change(Job, :count)
        expect(parent_job.reload.deleted_at).not_to be_present

        assert_response_schema_confirm 400
      end
    end
  end
end
