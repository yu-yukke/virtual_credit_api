# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Works::RelatedCategoryWorks", type: :request do
  describe "GET #index" do
    subject { get api_v1_work_related_category_works_path(work) }

    before {
      FactoryBot.create(:creator_mapping, :author, user: user, work: work)
    }

    let(:parent_category) { FactoryBot.create(:category) }
    let(:category) { FactoryBot.create(:category, ancestry: parent_category.id.to_s) }
    let(:work) { FactoryBot.create(:work, category: category) }
    let(:user) { FactoryBot.create(:user) }

    context "when category has only the work" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when other category has works exist" do
      before {
        FactoryBot.create(:creator_mapping, :author, user: user, work: other_work)
      }

      let(:category_2) { FactoryBot.create(:category, ancestry: parent_category.id.to_s) }
      let(:other_work) { FactoryBot.create(:work, category: category_2) }

      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 11 related works exist" do
      before {
        11.times do
          FactoryBot.create(:work, category: category)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 11 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 11

        assert_response_schema_confirm 200
      end
    end

    context "when 12 related works exist" do
      before {
        12.times do
          FactoryBot.create(:work, category: category)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 12 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 12

        assert_response_schema_confirm 200
      end
    end

    context "when 13 related works exist" do
      before {
        13.times do
          FactoryBot.create(:work, category: category)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 12 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 12

        assert_response_schema_confirm 200
      end
    end
  end
end
