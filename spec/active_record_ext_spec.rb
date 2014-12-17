require "spec_helper"

describe Shibaraku::ActiveRecordExt do
  shared_context "テスト用のデータ一式 Campaign" do
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
      @records << @future_future = Campaign.create(start_at: @future, end_at: @future)
    end
  end

  shared_context "テスト用のデータ一式 Event" do
    before do
      @now     = Time.now
      @old     = @now - 1.minute
      @future  = @now + 1.minute
      @records = []
      @records << @null_null     = Event.create(started_at: nil,     ended_at: nil)
      @records << @null_old      = Event.create(started_at: nil,     ended_at: @old)
      @records << @null_now      = Event.create(started_at: nil,     ended_at: @now)
      @records << @null_future   = Event.create(started_at: nil,     ended_at: @future)
      @records << @old_null      = Event.create(started_at: @old,    ended_at: nil)
      @records << @now_null      = Event.create(started_at: @now,    ended_at: nil)
      @records << @future_null   = Event.create(started_at: @future, ended_at: nil)
      @records << @old_old       = Event.create(started_at: @old,    ended_at: @old)
      @records << @old_now       = Event.create(started_at: @old,    ended_at: @now)
      @records << @old_future    = Event.create(started_at: @old,    ended_at: @future)
      @records << @now_now       = Event.create(started_at: @now,    ended_at: @now)
      @records << @now_future    = Event.create(started_at: @now,    ended_at: @future)
      @records << @future_future = Event.create(started_at: @future, ended_at: @future)
    end
  end

  let(:user) { double("user", super_user?: false) }

  describe ".in_time(now)" do
    context Campaign do
      include_context "テスト用のデータ一式 Campaign"

      context "normal user" do
        it "find from <= now < to" do
          expect(Campaign.in_time(user, @now).to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                                           @old_future, @now_future]
        end
      end

      context "super user" do
        let(:user) { double("user", super_user?: true) }

        before do
          @old_now.test_start_at = @old
          @old_now.test_end_at   = @now
          @old_now.save
        end

        it "find from <= now < to" do
          expect(Campaign.in_time(user, @now).to_a).to eq(@records - [@old_now])
        end
      end
    end

    context Event do
      include_context "テスト用のデータ一式 Event"
      it "find from <= now < to" do
        expect(Event.in_time(user, @now).to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                                      @old_future, @now_future]
      end
    end
  end

  describe ".in_time_fromto(now)" do
    context Campaign do
      include_context "テスト用のデータ一式 Campaign"

      it "find from <= now < to" do
        expect(Campaign.in_time_fromto(user, @now, @now).to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                                                      @old_future, @now_future]
      end
      it "find from <= now < to" do
        expect(Campaign.in_time_fromto(user, @future, @now).to_a).to eq [@null_null, @null_future, @old_null, @now_null,
                                                                         @future_null, @old_future, @now_future, @future_future]
      end
    end
  end

  describe "#in_time?(now)" do
    context Campaign do
      include_context "テスト用のデータ一式 Campaign"

      it "return from <= now < to" do
        in_time_arr = @records.select { |e| e.in_time?(user, @now) }
        expect(in_time_arr).to eq [@null_null, @null_future, @old_null, @now_null,
                                   @old_future, @now_future]
      end
    end

    context Event do
      include_context "テスト用のデータ一式 Event"

      it "return from <= now < to" do
        in_time_arr = @records.select { |e| e.in_time?(user, @now) }
        expect(in_time_arr).to eq [@null_null, @null_future, @old_null, @now_null,
                                   @old_future, @now_future]
      end
    end
  end

  describe "#human_readable_end_at" do
    subject { target.human_readable_end_at }

    context Campaign do
      let(:target) { Campaign.new(end_at: end_at) }

      context "xx:00:00" do
        let(:end_at) { Time.local(2014, 12, 5, 0, 0) }
        it { should == Time.local(2014, 12, 4, 23, 59, 59) }
      end

      context "xx:00:01" do
        let(:end_at) { Time.local(2014, 12, 5, 0, 1) }
        it { should == Time.local(2014, 12, 5, 0, 1) }
      end
    end

    context Event do
      let(:target) { Event.new(ended_at: ended_at) }

      context "xx:00:00" do
        let(:ended_at) { Time.local(2014, 12, 5, 0, 0) }
        it { should == Time.local(2014, 12, 4, 23, 59, 59) }
      end

      context "xx:00:01" do
        let(:ended_at) { Time.local(2014, 12, 5, 0, 1) }
        it { should == Time.local(2014, 12, 5, 0, 1) }
      end
    end
  end
end
