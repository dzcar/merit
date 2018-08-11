require 'test_helper'

describe Merit::Judge do
  before do
    @rule = Merit::Rule.new
    @rule.temporary=true
    @rule.to = :itself
    @rule.model_name = 'comment'
    @rule.block = ->(obj) { obj.nil? }
    @rule.badge_id = 1
    @action = Merit::Action.new(target_model: 'users', target_id: 2)
    @judge = Merit::Judge.new(@rule, {action: @action})
  end

  describe '#apply_badges' do
    describe 'when rules do not apply and the badge is temporary' do
      it 'should remove the badge' do
        comment = Comment.new
        sash_1 = Merit::Sash.new
        sash_2 = Merit::Sash.new
        sashes = [sash_1, sash_2]
        Comment.stubs(:find_by_id).with(2).returns(comment)
        badge = Merit::Badge.new
        badge.id = 1
        Merit::SashFinder.stubs(:find).with(@rule, @action).returns(sashes)
        Merit::Badge.stubs(:find).with(1).returns(badge)
        @judge.apply_badges
      end
    end
  end
end
