# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::ReleaseNotes", type: :request do
  describe "GET #index" do
    subject { get api_v1_release_notes_path }

    context "when no release_notes exist" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 release_notes exist" do
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

  describe "GET #show" do
    context "when release_note exists" do
      subject { get api_v1_release_note_path(release_note) }

      let(:release_note) { FactoryBot.create(:release_note) }

      it_behaves_like "return 200 success"

      it "is expected to return release_note" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["version"]).to eq release_note.version
        expect(json_body["subject"]).to eq release_note.subject
        expect(json_body["description"]).to eq release_note.description
        expect(json_body["released_at"]).to eq release_note.released_at.iso8601(3)

        assert_response_schema_confirm 200
      end
    end

    context "when release_note does not exist" do
      subject { get api_v1_release_note_path(10000000) }

      it_behaves_like "return 404 not found"

      it "is expected not to return release_note" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq "対象のレコードが存在しません。"

        assert_response_schema_confirm 404
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
          released_at: Time.zone.now
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
      let(:released_at) { "2022-05-08T00:00:00.000+09:00" }
      let(:params) {
        {
          version: "1.1",
          subject: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          released_at: released_at
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create release_note" do
        expect { subject }.to change(ReleaseNote, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["released_at"]).to eq released_at

        assert_response_schema_confirm 201
      end
    end
  end

  describe "PATCH #update" do
    let!(:release_note) {
      FactoryBot.create(
        :release_note,
        version: "1.1",
        released_at: DateTime.new(2022, 5, 9, 00, 00, 00, "+09:00")
      )
    }
    let!(:release_note2) { FactoryBot.create(:release_note, version: "1.2") }

    subject {
      patch api_v1_release_note_path(release_note), params: params
    }

    context "when version is nil" do
      let(:params) {
        {
          version: nil
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :version" do
        expect { subject }.not_to change { release_note.reload.version }

        assert_response_schema_confirm 422
      end
    end

    context "when version is blank" do
      let(:params) {
        {
          version: ""
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :version" do
        expect { subject }.not_to change { release_note.reload.version }

        assert_response_schema_confirm 422
      end
    end

    context "when version is duplicated" do
      let(:params) {
        {
          version: "1.2"
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :version" do
        expect { subject }.not_to change { release_note.reload.version }

        assert_response_schema_confirm 422
      end
    end

    context "when version is valid" do
      let(:params) {
        {
          version: "1.3"
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :version" do
        expect { subject }.to change { release_note.reload.version }.to("1.3")

        assert_response_schema_confirm 204
      end
    end

    context "when subject is nil" do
      let(:params) {
        {
          subject: nil
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :subject" do
        expect { subject }.not_to change { release_note.reload.subject }

        assert_response_schema_confirm 422
      end
    end

    context "when subject is blank" do
      let(:params) {
        {
          subject: ""
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :subject" do
        expect { subject }.not_to change { release_note.reload.subject }

        assert_response_schema_confirm 422
      end
    end

    context "when subject is valid" do
      let(:params) {
        {
          subject: "NewSubject"
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :subject" do
        expect { subject }.to change { release_note.reload.subject }.to("NewSubject")

        assert_response_schema_confirm 204
      end
    end

    context "when description is nil" do
      let(:params) {
        {
          description: nil
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :description" do
        expect { subject }.not_to change { release_note.reload.description }

        assert_response_schema_confirm 422
      end
    end

    context "when description is blank" do
      let(:params) {
        {
          description: ""
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :description" do
        expect { subject }.not_to change { release_note.reload.description }

        assert_response_schema_confirm 422
      end
    end

    context "when description is valid" do
      let(:params) {
        {
          description: "NewDescription"
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :description" do
        expect { subject }.to change { release_note.reload.description }.to("NewDescription")

        assert_response_schema_confirm 204
      end
    end

    context "when released_at is nil" do
      let(:params) {
        {
          released_at: nil
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :released_at" do
        expect { subject }.not_to change { release_note.reload.released_at }

        assert_response_schema_confirm 422
      end
    end

    context "when released_at is blank" do
      let(:params) {
        {
          released_at: ""
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :released_at" do
        expect { subject }.not_to change { release_note.reload.released_at }

        assert_response_schema_confirm 422
      end
    end

    context "when released_at is valid" do
      let(:released_at) { "2022-05-10T00:00:00.000+09:00" }
      let(:params) {
        {
          released_at: released_at
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :released_at" do
        expect { subject }.to change { release_note.reload.released_at.iso8601(3) }.to(released_at)

        assert_response_schema_confirm 204
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:release_note) { FactoryBot.create(:release_note) }

    subject { delete api_v1_release_note_path(release_note) }

    it_behaves_like "return 204 no content"

    it "is expected to delete release_note" do
      expect { subject }.to change(ReleaseNote, :count).by(-1)
      expect(release_note.reload.deleted_at).to be_present

      assert_response_schema_confirm 204
    end
  end
end
