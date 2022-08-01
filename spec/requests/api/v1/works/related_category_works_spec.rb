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

    context "when 3 related works exist" do
      before {
        3.times do
          FactoryBot.create(:work, category: category)
          FactoryBot.create(:creator_mapping, :author, user: user, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return 3 related works" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 3

        assert_response_schema_confirm 200
      end
    end

    context "when 4 related works exist" do
      before {
        4.times do
          FactoryBot.create(:work, category: category)
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

    context "when 5 related works exist" do
      before {
        5.times do
          FactoryBot.create(:work, category: category)
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
  end
end
