require "spec_helper"

describe Shibaraku::ActiveRecordExt do
  before do
    @now     = Time.now
    @old     = @now - 1.minute
    @future  = @now + 1.minute
    @old_old       = Campaign.create(start_at: @old,    end_at: @old)
    @old_now       = Campaign.create(start_at: @old,    end_at: @now)
    @old_future    = Campaign.create(start_at: @old,    end_at: @future)
    @now_now       = Campaign.create(start_at: @now,    end_at: @now)
    @now_future    = Campaign.create(start_at: @now,    end_at: @future)
    @feture_feture = Campaign.create(start_at: @future, end_at: @future)
  end

  describe ".in_time(now)" do
    it "find from <= now < to" do
      expect(Campaign.in_time.to_a).to eq [@old_future, @now_future]
    end
  end

  describe "#in_time?(now)" do
    it "return from <= now < to" do
      arr = [@old_old, @old_now, @old_future, @now_now, @now_future, @feture_feture]
      in_time_arr = arr.select { |e| e.in_time?(@now) }
      expect(in_time_arr).to eq [@old_future, @now_future]
    end
  end
end
