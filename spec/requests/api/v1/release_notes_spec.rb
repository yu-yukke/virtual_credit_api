# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::ReleaseNotes", type: :request do
  describe "GET #index" do
    subject { get api_v1_release_notes_path }

    context "when no release_notes" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 release_notes" do
      before { FactoryBot.create_list(:release_note, 10) }

      it_behaves_like "return 200 success"

      it "is expected to return all release_notes" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 10

        assert_response_schema_confirm 200
      end
    end
  end

  describe "POST #create" do
    subject {
      post api_v1_release_notes_path, params: params
    }

    context "when version is nil" do
      let(:params) {
        {
          version: nil,
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when version is blank" do
      let(:params) {
        {
          version: "",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when version is string" do
      let(:params) {
        {
          version: "TestVersion",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when version is duplicated" do
      before { FactoryBot.create(:release_note, version: "1.1") }

      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when version is present" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create release_note" do
        expect { subject }.to change(ReleaseNote, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["version"]).to eq "1.1"

        assert_response_schema_confirm 201
      end
    end

    context "when subject is nil" do
      let(:params) {
        {
          version: "1.1",
          subject: nil,
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when subject is blank" do
      let(:params) {
        {
          version: "1.1",
          subject: "",
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when subject is present" do
      let(:params) {
        {
          version: "1.1",
          subject: "TestSubject",
          description: Faker::Lorem.paragraph,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create release_note" do
        expect { subject }.to change(ReleaseNote, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["subject"]).to eq "TestSubject"

        assert_response_schema_confirm 201
      end
    end

    context "when description is nil" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: nil,
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when description is blank" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: "",
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when description is present" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: "TestDescription",
          released_at: Faker::Time.backward(days: 7, period: :evening)
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create release_note" do
        expect { subject }.to change(ReleaseNote, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["description"]).to eq "TestDescription"

        assert_response_schema_confirm 201
      end
    end

    context "when released_at is nil" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: nil
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when released_at is blank" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: ""
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create release_note" do
        expect { subject }.not_to change(ReleaseNote, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when released_at is present" do
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: "2022-05-08T00:00:00.000+09:00"
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create release_note" do
        expect { subject }.to change(ReleaseNote, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["released_at"]).to eq "2022-05-08T00:00:00.000+09:00"

        assert_response_schema_confirm 201
      end
    end
  end
end
