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

    context "when 10 creators exist" do
      before {
        10.times do |n|
          FactoryBot.create(:user)
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
end
