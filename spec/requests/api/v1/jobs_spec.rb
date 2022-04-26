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
      post api_v1_jobs_path,
      params: {
        job: {
          name: name,
          ancestry: ancestry
        }
      }
    }

    context "when name is nil" do
      let(:name) { nil }
      let(:ancestry) { nil }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is blank" do
      let(:name) { "" }
      let(:ancestry) { nil }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is duplicated" do
      before { FactoryBot.create(:job, name: "TestUser") }

      let(:name) { "TestUser" }
      let(:ancestry) { nil }

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is present" do
      let(:name) { Faker::Name.name }
      let(:ancestry) { nil }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to eq name

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is nil" do
      let(:name) { Faker::Name.name }
      let(:ancestry) { nil }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq ancestry

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is blank" do
      let(:name) { Faker::Name.name }
      let(:ancestry) { "" }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when ancestry with some parent Job is present" do
      let!(:parent_job) { FactoryBot.create(:job) }
      let(:name) { Faker::Name.name }
      let(:ancestry) { parent_job.id.to_s }

      it_behaves_like "return 201 created"

      it "is expected to create Job" do
        expect { subject }.to change(Job, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq ancestry

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry with no parent Job is present" do
      let(:name) { Faker::Name.name }
      let(:ancestry) { "1" }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create Job" do
        expect { subject }.not_to change(Job, :count)

        assert_response_schema_confirm 422
      end
    end
  end
end
