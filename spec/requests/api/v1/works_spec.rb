# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Works", type: :request do
  describe "GET #index" do
    subject { get api_v1_works_path }

    context "when no works exist" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 works exist" do
      before {
        10.times do |n|
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      let(:user) { FactoryBot.create(:user) }

      it_behaves_like "return 200 success"

      it "is expected to return all jobs" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 10

        assert_response_schema_confirm 200
      end
    end
  end

  describe "GET #show" do
    context "when work exists" do
      subject { get api_v1_work_path(work) }

      before {
        FactoryBot.create(:creator_mapping, :author, user: user, work: work)
      }

      let(:work) { FactoryBot.create(:work) }
      let(:user) { FactoryBot.create(:user) }

      it_behaves_like "return 200 success"

      it "is expected to return work" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to eq work.name
        expect(json_body["description"]).to eq work.description

        assert_response_schema_confirm 200
      end
    end

    context "when work does not exist" do
      subject { get api_v1_work_path(10000000) }

      it_behaves_like "return 404 not found"

      it "is expected not to return work" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq "対象のレコードが存在しません。"

        assert_response_schema_confirm 404
      end
    end
  end
end
