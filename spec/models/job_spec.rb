require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "associations" do
    it { should have_many(:job_mappings) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
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
