// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) => TokenPair(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$TokenPairToJson(TokenPair instance) => <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

SendOTPRequest _$SendOTPRequestFromJson(Map<String, dynamic> json) =>
    SendOTPRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$SendOTPRequestToJson(SendOTPRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

LoginOTPRequest _$LoginOTPRequestFromJson(Map<String, dynamic> json) =>
    LoginOTPRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$LoginOTPRequestToJson(LoginOTPRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) =>
    LogoutRequest(
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$LogoutRequestToJson(LogoutRequest instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
    };

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    RefreshTokenRequest(
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$RefreshTokenRequestToJson(
        RefreshTokenRequest instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
    };
