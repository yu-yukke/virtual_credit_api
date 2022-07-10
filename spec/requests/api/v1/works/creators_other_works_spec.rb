# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Works::CreatorsOtherWorks", type: :request do
  describe "GET #index" do
    subject { get api_v1_work_creators_other_works_path(work) }

    before {
      FactoryBot.create(:creator_mapping, :author, user: user, work: work)
      FactoryBot.create(:creator_mapping, user: user_2, work: work)
    }

    let(:work) { FactoryBot.create(:work) }
    let(:user) { FactoryBot.create(:user) }
    let(:user_2) { FactoryBot.create(:user) }

    context "when creators have only the work" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when creators have 4 other works" do
      before {
        4.times do
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 4 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 4

        assert_response_schema_confirm 200
      end
    end

    context "when creators have 5 other works" do
      before {
        2.times do
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end

        3.times do
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user_2, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 5 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 5

        assert_response_schema_confirm 200
      end
    end

    context "when creators have 6 other works" do
      before {
        3.times do
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end

        3.times do
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: user_2, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 5 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 5

        assert_response_schema_confirm 200
      end
    end
  end
end
