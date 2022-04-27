# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
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
#  index_jobs_on_deleted_at  (deleted_at)
#
require "rails_helper"

RSpec.describe Job, type: :model do
  describe "associations" do
    it { should have_many(:job_mappings) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    context "uniqueness" do
      before { FactoryBot.create(:job, name: "TestUser") }

      let(:job) { FactoryBot.build(:job, name: "TestUser") }

      it "is expected to validate that :name cannot be duplicated" do
        expect(job).not_to be_valid
      end
    end

    context "check_parent_exists" do
      context "when parent is not exist" do
        let(:job) { FactoryBot.build(:job, ancestry: "1") }

        it "is expected to validate that parent must be exist" do
          expect(job).not_to be_valid
        end
      end

      context "when parent is exist" do
        let!(:parent_job) { FactoryBot.create(:job) }
        let(:job) { FactoryBot.build(:job, ancestry: parent_job.id.to_s) }

        it "is expected to be valid" do
          expect(job).to be_valid
        end
      end
    end
  end

  describe "ancestry" do
    let(:parent_job_1) { FactoryBot.create(:job) }
    let(:parent_job_2) { FactoryBot.create(:job) }
    let(:child_job_1) { FactoryBot.create(:job, ancestry: parent_job_1.id) }
    let(:child_job_2) { FactoryBot.create(:job, ancestry: parent_job_1.id) }
    let(:child_job_3) { FactoryBot.create(:job, ancestry: parent_job_2.id) }

    it "is expected root has no parent" do
      expect(parent_job_1.parent).to eq nil
      expect(parent_job_2.parent).to eq nil
    end

    it "is expected children has no children" do
      expect(child_job_1.children).to be_empty
      expect(child_job_2.children).to be_empty
      expect(child_job_3.children).to be_empty
    end

    it "is expected parent has children correctly" do
      expect(parent_job_1.children).to contain_exactly(child_job_1, child_job_2)
      expect(parent_job_2.children).to contain_exactly(child_job_3)
    end
  end
end
