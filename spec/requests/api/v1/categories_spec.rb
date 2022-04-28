# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Categories", type: :request do
  describe "GET #index" do
    subject { get api_v1_categories_path }

    context "when no categories" do
      it_behaves_like "return 200 success"

      it "is expected to return empty" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body).to be_empty

        assert_response_schema_confirm 200
      end
    end

    context "when 10 categories" do
      before { FactoryBot.create_list(:category, 10) }

      it_behaves_like "return 200 success"

      it "is expected to return all categories" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body.length).to eq 10

        assert_response_schema_confirm 200
      end
    end
  end

  describe "GET #show" do
    context "when category exists" do
      subject { get api_v1_category_path(category) }

      let(:category) { FactoryBot.create(:category) }

      it_behaves_like "return 200 success"

      it "is expected to return category" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to eq category.name
        expect(json_body["ancestry"]).to eq category.ancestry

        assert_response_schema_confirm 200
      end
    end

    context "when category does not exist" do
      subject { get api_v1_category_path(10000000) }

      it_behaves_like "return 404 not found"

      it "is expected not to return category" do
        subject

        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq "対象のレコードが存在しません。"

        assert_response_schema_confirm 404
      end
    end
  end

  describe "POST #create" do
    subject {
      post api_v1_categories_path, params: params
    }

    context "when name is nil" do
      let(:params) {
        {
          category: {
            name: nil
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create category" do
        expect { subject }.not_to change(Category, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is blank" do
      let(:params) {
        {
          category: {
            name: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create category" do
        expect { subject }.not_to change(Category, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is duplicated" do
      before { FactoryBot.create(:category, name: "TestCategory") }

      let(:params) {
        {
          category: {
            name: "TestCategory"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create category" do
        expect { subject }.not_to change(Category, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when name is present" do
      let(:params) {
        {
          category: {
            name: "TestCategory"
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create category" do
        expect { subject }.to change(Category, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to eq "TestCategory"

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is nil" do
      let(:params) {
        {
          category: {
            name: Faker::Name.name,
            ancestry: nil
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create category" do
        expect { subject }.to change(Category, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq nil

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry is blank" do
      let(:params) {
        {
          category: {
            name: Faker::Name.name,
            ancestry: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create category" do
        expect { subject }.not_to change(Category, :count)

        assert_response_schema_confirm 422
      end
    end

    context "when ancestry with some parent category is present" do
      let!(:parent_category) { FactoryBot.create(:category) }
      let(:params) {
        {
          category: {
            name: Faker::Name.name,
            ancestry: parent_category.id.to_s
          }
        }
      }

      it_behaves_like "return 201 created"

      it "is expected to create category" do
        expect { subject }.to change(Category, :count).by 1

        json_body = JSON.parse(response.body)
        expect(json_body["ancestry"]).to eq parent_category.id.to_s

        assert_response_schema_confirm 201
      end
    end

    context "when ancestry with no parent category is present" do
      let(:params) {
        {
          category: {
            name: Faker::Name.name,
            ancestry: "1"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to create category" do
        expect { subject }.not_to change(Category, :count)

        assert_response_schema_confirm 422
      end
    end
  end

  describe "PATCH #update" do
    let!(:parent_category) { FactoryBot.create(:category, name: "ParentCategory") }
    let(:parent_category_2) { FactoryBot.create(:category) }
    let!(:category) { FactoryBot.create(:category, name: "TestCategory", ancestry: parent_category.id.to_s) }

    subject {
      patch api_v1_category_path(category), params: params
    }

    context "when name is nil" do
      let(:params) {
        {
          category: {
            name: nil
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { category.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is blank" do
      let(:params) {
        {
          category: {
            name: ""
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { category.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is duplicated" do
      let(:params) {
        {
          category: {
            name: "ParentCategory"
          }
        }
      }

      it_behaves_like "return 422 unprocessable entity"

      it "is expected not to change :name" do
        expect { subject }.not_to change { category.reload.name }

        assert_response_schema_confirm 422
      end
    end

    context "when name is valid" do
      let(:params) {
        {
          category: {
            name: "NewName"
          }
        }
      }

      it_behaves_like "return 204 no content"

      it "is expected to change :name" do
        expect { subject }.to change { category.reload.name }.to("NewName")

        assert_response_schema_confirm 204
      end
    end
  end
end
