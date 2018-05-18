require "rails_helper"

describe Teachers::Topics::UpdateOrderIndexes do
  let(:course) { create :course }

  before do
    0.upto(4) { |i| create :topic, course: course, order_index: i }
  end

  describe "#call" do
    subject(:interactor_call) { described_class.call(topic: topic, new_index: 1) }

    let!(:topic) { Topic.first }

    it "changes order indexes of corresponding topics correctly" do
      expect(interactor_call).to be_success
      expect(Topic.order(:id).pluck(:order_index)).to eq([1, 0, 2, 3, 4])
    end
  end
end
