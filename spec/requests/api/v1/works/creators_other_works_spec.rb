# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Works::CreatorsOtherWorks", type: :request do
  describe "GET #index" do
    subject { get api_v1_work_creators_other_works_path(work) }

    let(:work) { FactoryBot.create(:work) }

    it_behaves_like "return 200 success"

    it "expected not to include the work" do
    end
  end
end
