# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(191)      not null
#  ancestry   :string(191)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_categories_on_deleted_at  (deleted_at)
#
require "rails_helper"

RSpec.describe Category, type: :model do
  describe "associations" do
    it { should have_many(:works) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    context "uniqueness" do
      before { FactoryBot.create(:category, name: "TestUser") }

      let(:category) { FactoryBot.build(:category, name: "TestUser") }

      it "is expected to validate that :name cannot be duplicated" do
        expect(category).not_to be_valid
      end
    end

    context "check_parent_exists" do
      context "when parent is not exist" do
        let(:category) { FactoryBot.build(:category, ancestry: "1") }

        it "is expected to validate that parent must be exist" do
          expect(category).not_to be_valid
        end
      end

      context "when parent is exist" do
        let!(:parent_category) { FactoryBot.create(:category) }
        let(:category) { FactoryBot.build(:category, ancestry: parent_category.id.to_s) }

        it "is expected to be valid" do
          expect(category).to be_valid
        end
      end
    end
  end

  describe "ancestry" do
    let(:parent_category_1) { FactoryBot.create(:category) }
    let(:parent_category_2) { FactoryBot.create(:category) }
    let(:child_category_1) { FactoryBot.create(:category, ancestry: parent_category_1.id) }
    let(:child_category_2) { FactoryBot.create(:category, ancestry: parent_category_1.id) }
    let(:child_category_3) { FactoryBot.create(:category, ancestry: parent_category_2.id) }

    it "is expected root has no parent" do
      expect(parent_category_1.parent).to eq nil
      expect(parent_category_2.parent).to eq nil
    end

    it "is expected children has no children" do
      expect(child_category_1.children).to be_empty
      expect(child_category_2.children).to be_empty
      expect(child_category_3.children).to be_empty
    end

    it "is expected parent has children correctly" do
      expect(parent_category_1.children).to contain_exactly(child_category_1, child_category_2)
      expect(parent_category_2.children).to contain_exactly(child_category_3)
    end
  end
end
