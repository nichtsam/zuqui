import 'package:dio/dio.dart';
import 'package:zuqui/core/result.dart';
import 'package:zuqui/service/auth/model.dart';
import 'package:zuqui/service/auth/token.dart';

abstract class AuthSerice {
  Future<Result<String>> getAccessToken();

  Future<Result<void>> refreshTokenPair();
  Future<Result<void>> sendOTP(String email);
  Future<Result<void>> loginOTP(String email, String otp);
  Future<Result<void>> logout();
}

class AuthSericeImpl implements AuthSerice {
  final Dio dio;
  final TokenStorage tokenStorage;

  const AuthSericeImpl({required this.dio, required this.tokenStorage});

  @override
  Future<Result<String>> getAccessToken() async {
    final result = await tokenStorage.loadTokenPair();
    return result.match(
      onOk: (tokenPair) {
        return Result.ok(tokenPair.access);
      },
      onError: (error) {
        return Result.error(error);
      },
    );
  }

  @override
  Future<Result<void>> refreshTokenPair() async {
    final result = await tokenStorage.loadTokenPair();
    return result.match(
      onOk: (tokenPair) async {
        try {
          final res = await dio.post(
            "/auth/token/refresh",
            data: RefreshTokenRequest(refresh: tokenPair.refresh).toJson(),
          );

          return await tokenStorage.saveTokenPair(TokenPair.fromJson(res.data));
        } catch (error) {
          if (error is Exception) {
            return Result.error(error);
          }

          return Result.error(Exception(error.toString()));
        }
      },
      onError: (error) {
        return Result.error(error);
      },
    );
  }

  @override
  Future<Result<void>> sendOTP(String email) async {
    try {
      await dio.post(
        "/auth/login/otp",
        data: SendOTPRequest(email: email).toJson(),
      );

      return Result.ok(null);
    } catch (error) {
      if (error is Exception) {
        return Result.error(error);
      }

      return Result.error(Exception(error.toString()));
    }
  }

  @override
  Future<Result<void>> loginOTP(String email, String otp) async {
    try {
      final res = await dio.post(
        "/auth/login/otp",
        data: LoginOTPRequest(email: email, otp: otp).toJson(),
      );

      return await tokenStorage.saveTokenPair(TokenPair.fromJson(res.data));
    } catch (error) {
      if (error is Exception) {
        return Result.error(error);
      }

      return Result.error(Exception(error.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    final result = await tokenStorage.loadTokenPair();
    return result.match(
      onOk: (tokenPair) async {
        try {
          await dio.post(
            "/auth/logout",
            data: LogoutRequest(refresh: tokenPair.refresh).toJson(),
          );
          return await tokenStorage.clearTokens();
        } catch (error) {
          if (error is Exception) {
            return Result.error(error);
          }

          return Result.error(Exception(error.toString()));
        }
      },
      onError: (error) => Result.error(error),
    );
  }
}
