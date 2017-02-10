require "spec_helper"

describe "ActiveHash" do
  let(:user) { double("user", super_user?: false) }

  describe "#in_time" do
    subject { Gift.in_time(user, now) }
    context "now < from" do
      let(:now) { Time.local(2016, 12, 10)}
      it { should eq [] }
    end
    context "from <= now < to" do
      let(:now) { Time.local(2017, 1, 10)}
      it { should eq [Gift.find(1)] }
    end
    context "to <= now" do
      let(:now) { Time.local(2017, 2, 1)}
      it { should eq [] }
    end
  end
end
