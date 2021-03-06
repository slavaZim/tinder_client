# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: authgateway.proto

require 'google/protobuf'

require 'google/protobuf/wrappers_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("authgateway.proto", :syntax => :proto3) do
    add_message "tinder.services.authgateway.FacebookToken" do
      optional :external_token, :string, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.Phone" do
      optional :phone, :string, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.PhoneOtpResend" do
      optional :phone, :message, 1, "google.protobuf.StringValue"
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.PhoneOtp" do
      optional :phone, :message, 1, "google.protobuf.StringValue"
      optional :otp, :string, 2
      optional :refresh_token, :message, 3, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.Email" do
      optional :email, :string, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
      optional :marketing_opt_in, :message, 3, "google.protobuf.BoolValue"
    end
    add_message "tinder.services.authgateway.EmailOtpResend" do
      optional :email, :message, 1, "google.protobuf.StringValue"
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.GoogleToken" do
      optional :external_token, :string, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
      optional :marketing_opt_in, :message, 3, "google.protobuf.BoolValue"
      optional :user_behavior, :message, 4, "google.protobuf.BoolValue"
    end
    add_message "tinder.services.authgateway.EmailOtp" do
      optional :email, :message, 1, "google.protobuf.StringValue"
      optional :otp, :string, 2
      optional :refresh_token, :message, 3, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.AppleToken" do
      optional :external_token, :string, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
      optional :raw_nonce, :message, 3, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.GetInitialState" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.RefreshAuth" do
      optional :refresh_token, :string, 1
    end
    add_message "tinder.services.authgateway.DismissSocialConnectionList" do
      optional :refresh_token, :string, 1
    end
    add_message "tinder.services.authgateway.AuthGatewayRequest" do
      oneof :factor do
        optional :phone, :message, 1, "tinder.services.authgateway.Phone"
        optional :phone_otp, :message, 2, "tinder.services.authgateway.PhoneOtp"
        optional :email, :message, 3, "tinder.services.authgateway.Email"
        optional :google_token, :message, 4, "tinder.services.authgateway.GoogleToken"
        optional :email_otp, :message, 5, "tinder.services.authgateway.EmailOtp"
        optional :facebook_token, :message, 6, "tinder.services.authgateway.FacebookToken"
        optional :phone_otp_resend, :message, 7, "tinder.services.authgateway.PhoneOtpResend"
        optional :email_otp_resend, :message, 8, "tinder.services.authgateway.EmailOtpResend"
        optional :get_initial_state, :message, 9, "tinder.services.authgateway.GetInitialState"
        optional :refresh_auth, :message, 10, "tinder.services.authgateway.RefreshAuth"
        optional :apple_token, :message, 11, "tinder.services.authgateway.AppleToken"
        optional :dismiss_social_connection_list, :message, 12, "tinder.services.authgateway.DismissSocialConnectionList"
      end
    end
    add_message "tinder.services.authgateway.GetPhoneState" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.ValidatePhoneOtpState" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
      optional :phone, :string, 2
      optional :otp_length, :message, 3, "google.protobuf.Int32Value"
      optional :sms_sent, :message, 4, "google.protobuf.BoolValue"
    end
    add_message "tinder.services.authgateway.EmailMarketing" do
      optional :show_marketing_opt_in, :message, 2, "google.protobuf.BoolValue"
      optional :show_strict_opt_in, :message, 3, "google.protobuf.BoolValue"
      optional :checked_by_default, :message, 4, "google.protobuf.BoolValue"
    end
    add_message "tinder.services.authgateway.GetEmailState" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
      optional :email_marketing, :message, 2, "tinder.services.authgateway.EmailMarketing"
    end
    add_message "tinder.services.authgateway.ValidateEmailOtpState" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
      optional :otp_length, :message, 4, "google.protobuf.Int32Value"
      optional :email_sent, :message, 5, "google.protobuf.BoolValue"
      optional :email_marketing, :message, 6, "tinder.services.authgateway.EmailMarketing"
      oneof :email do
        optional :unmasked_email, :string, 2
        optional :masked_email, :string, 3
      end
    end
    add_message "tinder.services.authgateway.OnboardingState" do
      optional :refresh_token, :string, 1
      optional :onboarding_token, :string, 2
    end
    add_message "tinder.services.authgateway.LoginResult" do
      optional :refresh_token, :string, 1
      optional :auth_token, :string, 2
      optional :captcha, :enum, 3, "tinder.services.authgateway.LoginResult.Captcha"
      optional :user_id, :string, 4
      optional :auth_token_ttl, :message, 5, "google.protobuf.Int64Value"
    end
    add_enum "tinder.services.authgateway.LoginResult.Captcha" do
      value :CAPTCHA_INVALID, 0
      value :CAPTCHA_V1, 1
      value :CAPTCHA_V2, 2
    end
    add_message "tinder.services.authgateway.AppleAccountNotFound" do
      optional :will_link, :bool, 1
      optional :refresh_token, :message, 2, "google.protobuf.StringValue"
    end
    add_message "tinder.services.authgateway.SocialConnection" do
      optional :service, :enum, 1, "tinder.services.authgateway.SocialConnection.Service"
    end
    add_enum "tinder.services.authgateway.SocialConnection.Service" do
      value :SERVICE_INVALID, 0
      value :SERVICE_FACEBOOK, 1
      value :SERVICE_GOOGLE, 2
      value :SERVICE_APPLE, 3
    end
    add_message "tinder.services.authgateway.SocialConnectionList" do
      optional :refresh_token, :message, 1, "google.protobuf.StringValue"
      repeated :connections, :message, 2, "tinder.services.authgateway.SocialConnection"
    end
    add_message "tinder.services.authgateway.AuthGatewayResponse" do
      optional :meta, :message, 1, "tinder.services.authgateway.MetaProto"
      optional :error, :message, 2, "tinder.services.authgateway.ErrorProto"
      oneof :data do
        optional :get_phone_state, :message, 3, "tinder.services.authgateway.GetPhoneState"
        optional :validate_phone_otp_state, :message, 4, "tinder.services.authgateway.ValidatePhoneOtpState"
        optional :get_email_state, :message, 5, "tinder.services.authgateway.GetEmailState"
        optional :validate_email_otp_state, :message, 6, "tinder.services.authgateway.ValidateEmailOtpState"
        optional :onboarding_state, :message, 7, "tinder.services.authgateway.OnboardingState"
        optional :login_result, :message, 8, "tinder.services.authgateway.LoginResult"
        optional :social_connection_list, :message, 9, "tinder.services.authgateway.SocialConnectionList"
        optional :apple_account_not_found, :message, 10, "tinder.services.authgateway.AppleAccountNotFound"
      end
    end
    add_message "tinder.services.authgateway.Verification" do
      optional :type, :string, 1
      optional :state, :string, 2
    end
    add_message "tinder.services.authgateway.UnderageBan" do
      optional :underage_ttl_duration_ms, :message, 1, "google.protobuf.Int64Value"
      optional :underage_token, :message, 2, "google.protobuf.StringValue"
      optional :verification, :message, 3, "tinder.services.authgateway.Verification"
    end
    add_message "tinder.services.authgateway.BanAppeal" do
      optional :challenge_type, :string, 1
      optional :challenge_token, :string, 2
      optional :refresh_token, :string, 3
    end
    add_message "tinder.services.authgateway.BanReason" do
      oneof :reason do
        optional :underage_ban, :message, 1, "tinder.services.authgateway.UnderageBan"
        optional :ban_appeal, :message, 2, "tinder.services.authgateway.BanAppeal"
      end
    end
    add_message "tinder.services.authgateway.ErrorProto" do
      optional :code, :int32, 1
      optional :message, :string, 2
      optional :ban_reason, :message, 3, "tinder.services.authgateway.BanReason"
    end
    add_message "tinder.services.authgateway.MetaProto" do
      optional :upstream_time, :message, 1, "google.protobuf.Timestamp"
      optional :start_time, :message, 2, "google.protobuf.Timestamp"
    end
  end
end

module Tinder
  module Services
    module Authgateway
      FacebookToken = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.FacebookToken").msgclass
      Phone = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.Phone").msgclass
      PhoneOtpResend = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.PhoneOtpResend").msgclass
      PhoneOtp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.PhoneOtp").msgclass
      Email = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.Email").msgclass
      EmailOtpResend = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.EmailOtpResend").msgclass
      GoogleToken = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.GoogleToken").msgclass
      EmailOtp = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.EmailOtp").msgclass
      AppleToken = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.AppleToken").msgclass
      GetInitialState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.GetInitialState").msgclass
      RefreshAuth = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.RefreshAuth").msgclass
      DismissSocialConnectionList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.DismissSocialConnectionList").msgclass
      AuthGatewayRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.AuthGatewayRequest").msgclass
      GetPhoneState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.GetPhoneState").msgclass
      ValidatePhoneOtpState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.ValidatePhoneOtpState").msgclass
      EmailMarketing = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.EmailMarketing").msgclass
      GetEmailState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.GetEmailState").msgclass
      ValidateEmailOtpState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.ValidateEmailOtpState").msgclass
      OnboardingState = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.OnboardingState").msgclass
      LoginResult = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.LoginResult").msgclass
      LoginResult::Captcha = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.LoginResult.Captcha").enummodule
      AppleAccountNotFound = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.AppleAccountNotFound").msgclass
      SocialConnection = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.SocialConnection").msgclass
      SocialConnection::Service = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.SocialConnection.Service").enummodule
      SocialConnectionList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.SocialConnectionList").msgclass
      AuthGatewayResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.AuthGatewayResponse").msgclass
      Verification = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.Verification").msgclass
      UnderageBan = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.UnderageBan").msgclass
      BanAppeal = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.BanAppeal").msgclass
      BanReason = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.BanReason").msgclass
      ErrorProto = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.ErrorProto").msgclass
      MetaProto = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tinder.services.authgateway.MetaProto").msgclass
    end
  end
end
