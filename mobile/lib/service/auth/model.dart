import 'package:json_annotation/json_annotation.dart';

part "model.g.dart";

@JsonSerializable()
class TokenPair {
  final String access;
  final String refresh;

  TokenPair({required this.access, required this.refresh});

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);

  Map<String, dynamic> toJson() => _$TokenPairToJson(this);
}

@JsonSerializable()
class SendOTPRequest {
  final String email;

  SendOTPRequest({required this.email});

  factory SendOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOTPRequestToJson(this);
}

@JsonSerializable()
class LoginOTPRequest {
  final String email;
  final String otp;

  LoginOTPRequest({required this.email, required this.otp});

  factory LoginOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginOTPRequestToJson(this);
}

@JsonSerializable()
class LogoutRequest {
  final String refresh;

  LogoutRequest({required this.refresh});

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}

@JsonSerializable()
class RefreshTokenRequest {
  final String refresh;

  RefreshTokenRequest({required this.refresh});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
