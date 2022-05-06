# frozen_string_literal: true

# == Schema Information
#
# Table name: release_notes
#
#  id          :bigint           not null, primary key
#  version     :decimal(10, )    not null
#  subject     :string(191)      not null
#  description :text(65535)      not null
#  released_at :datetime         not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_release_notes_on_deleted_at  (deleted_at)
#
require "rails_helper"

RSpec.describe ReleaseNote, type: :model do
  describe "validations" do
    it { should validate_presence_of(:version) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:released_at) }

    context "version_numericality" do
      context "when version is not numeric" do
        let(:release_note) { FactoryBot.build(:release_note, version: "TestVersion") }

        it "is expected to validate that :version must be numeric" do
          expect(release_note).not_to be_valid
        end
      end

      context "when version is numeric" do
        let(:release_note) { FactoryBot.build(:release_note, version: "1.1") }

        it "is expected to be valid" do
          expect(release_note).to be_valid
        end
      end
    end

    context "version_uniqueness" do
      before { FactoryBot.create(:release_note, version: "1.1") }

      let(:release_note) { FactoryBot.build(:release_note, version: "1.1") }

      it "is expected to validate that :version cannot be duplicated" do
        expect(release_note).not_to be_valid
      end
    end
  end
end
