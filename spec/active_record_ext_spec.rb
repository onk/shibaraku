require "spec_helper"

describe Shibaraku::ActiveRecordExt do
  shared_context "テスト用のデータ一式" do
    before do
      @now     = Time.now
      @old     = @now - 1.minute
      @future  = @now + 1.minute
      @records = []
      @records << @null_null     = Campaign.create(start_at: nil,     end_at: nil)
      @records << @null_old      = Campaign.create(start_at: nil,     end_at: @old)
      @records << @null_now      = Campaign.create(start_at: nil,     end_at: @now)
      @records << @null_future   = Campaign.create(start_at: nil,     end_at: @future)
      @records << @old_null      = Campaign.create(start_at: @old,    end_at: nil)
      @records << @now_null      = Campaign.create(start_at: @now,    end_at: nil)
      @records << @future_null   = Campaign.create(start_at: @future, end_at: nil)
      @records << @old_old       = Campaign.create(start_at: @old,    end_at: @old)
      @records << @old_now       = Campaign.create(start_at: @old,    end_at: @now)
      @records << @old_future    = Campaign.create(start_at: @old,    end_at: @future)
      @records << @now_now       = Campaign.create(start_at: @now,    end_at: @now)
      @records << @now_future    = Campaign.create(start_at: @now,    end_at: @future)
      @records << @feture_feture = Campaign.create(start_at: @future, end_at: @future)
    end
  end

  describe ".in_time(now)" do
    include_context "テスト用のデータ一式"
    it "find from <= now < to" do
      expect(Campaign.in_time.to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                           @old_future, @now_future]
    end
  end

  describe "#in_time?(now)" do
    include_context "テスト用のデータ一式"

    it "return from <= now < to" do
      in_time_arr = @records.select { |e| e.in_time?(@now) }
      expect(in_time_arr).to eq [@null_null, @null_future, @old_null, @now_null,
                                 @old_future, @now_future]
    end
  end

  describe "#human_readable_end_at" do
    subject { campaign.human_readable_end_at }
    let(:campaign) { Campaign.new(end_at: end_at) }

    context "xx:00:00" do
      let(:end_at) { Time.local(2014, 12, 5, 0, 0) }
      it { should == Time.local(2014, 12, 4, 23, 59, 59) }
    end

    context "xx:00:01" do
      let(:end_at) { Time.local(2014, 12, 5, 0, 1) }
      it { should == Time.local(2014, 12, 5, 0, 1) }
    end
  end
end
