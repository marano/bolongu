require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :accounts

  def test_should_create_account
    assert_difference 'Account.count' do
      account = create_account
      assert !account.new_record?, "#{account.errors.full_messages.to_sentence}"
    end
  end

  def test_should_initialize_activation_code_upon_creation
    account = create_account
    account.reload
    assert_not_nil account.activation_code
  end

  def test_should_require_login
    assert_no_difference 'Account.count' do
      u = create_account(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Account.count' do
      u = create_account(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Account.count' do
      u = create_account(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Account.count' do
      u = create_account(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    accounts(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal accounts(:quentin), Account.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    accounts(:quentin).update_attributes(:login => 'quentin2')
    assert_equal accounts(:quentin), Account.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_account
    assert_equal accounts(:quentin), Account.authenticate('quentin', 'monkey')
  end

  def test_should_set_remember_token
    accounts(:quentin).remember_me
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    accounts(:quentin).remember_me
    assert_not_nil accounts(:quentin).remember_token
    accounts(:quentin).forget_me
    assert_nil accounts(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    accounts(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert accounts(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    accounts(:quentin).remember_me_until time
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert_equal accounts(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    accounts(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil accounts(:quentin).remember_token
    assert_not_nil accounts(:quentin).remember_token_expires_at
    assert accounts(:quentin).remember_token_expires_at.between?(before, after)
  end

protected
  def create_account(options = {})
    record = Account.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
