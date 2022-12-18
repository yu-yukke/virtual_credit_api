# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Creators", type: :request do
  describe "GET #index" do
    subject { get api_v1_creators_path }

    context "when no creators exist" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 creators with works exist" do
      before {
        10.times do |n|
          FactoryBot.create(:user)
          FactoryBot.create(:work)
          FactoryBot.create(:creator_mapping, :author, user: User.last, work: Work.last)
        end
      }

      it_behaves_like "return 200 success"

      it "is expected to return all creators" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 10

        assert_response_schema_confirm 200
      end
    end
  end

  describe "GET #show" do
    context "when creator exists" do
      subject { get api_v1_creator_path(user) }

      let(:user) { FactoryBot.create(:user) }

      context "with no works" do
        it_behaves_like "return 404 not found"

        it "is expected not to return work" do
          subject

          json_body = JSON.parse(response.body)
          expect(json_body["error"]).to eq "対象のレコードが存在しません。"

          assert_response_schema_confirm 404
        end
      end

      context "with works" do
        before {
          FactoryBot.create(:creator_mapping, :author, user: user, work: work1)
          FactoryBot.create(:creator_mapping, :author, user: user, work: work2)
        }

        let(:work1) { FactoryBot.create(:work) }
        let(:work2) { FactoryBot.create(:work) }

        it_behaves_like "return 200 success"

        it "is expected to return work" do
          subject

          json_body = JSON.parse(response.body)
          expect(json_body["name"]).to eq user.name
          expect(json_body["description"]).to eq user.description
          expect(json_body["thumb_image_url"]).to eq user.thumb_image_url
          expect(json_body["main_image_url"]).to eq user.main_image_url
          expect(json_body["work_with_images"].length).to eq 2

          assert_response_schema_confirm 200
        end
      end
    end

    context "when work does not exist" do
      subject { get api_v1_creator_path(10000000) }

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
