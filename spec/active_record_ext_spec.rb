require "spec_helper"

describe Shibaraku::ActiveRecordExt do
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

  describe ".in_time(now)" do
    it "find from <= now < to" do
      expect(Campaign.in_time.to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                           @old_future, @now_future]
    end
  end

  describe "#in_time?(now)" do
    it "return from <= now < to" do
      in_time_arr = @records.select { |e| e.in_time?(@now) }
      expect(in_time_arr).to eq [@null_null, @null_future, @old_null, @now_null,
                                 @old_future, @now_future]
    end
  end
end
