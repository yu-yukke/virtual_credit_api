# frozen_string_literal: true

shared_examples "return 200 success" do
  it { is_expected.to eq 200 }
end

shared_examples "return 201 created" do
  it { is_expected.to eq 201 }
end

shared_examples "return 204 no content" do
  it { is_expected.to eq 204 }
end

shared_examples "return 400 bad request" do
  it { is_expected.to eq 400 }
end

shared_examples "return 404 not found" do
  it { is_expected.to eq 404}
end

shared_examples "return 422 unprocessable entity" do
  it { is_expected.to eq 422 }
end
