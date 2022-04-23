require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "#create" do
    context "name" do
      let(:job) { FactoryBot.build(:job, name: name) }

      context "with presence" do
        let(:name) { "動画クリエイター" }

        it "is valid" do
          expect(job).to be_valid
        end
      end

      context "with nil" do
        let(:name) { nil }

        it "is invalid" do
          expect(job).to be_invalid
        end
      end

      context "with blank" do
        let(:name) { "" }

        it "is invalid" do
          expect(job).to be_invalid
        end
      end
    end
  end
end
