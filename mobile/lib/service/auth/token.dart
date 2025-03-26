import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zuqui/core/result.dart';
import 'package:zuqui/service/auth/model.dart';

abstract class TokenStorage {
  Future<Result<void>> saveTokenPair(TokenPair tokenPair);
  Future<Result<TokenPair>> loadTokenPair();
  Future<Result<String>> loadAccessToken();
  Future<Result<String>> loadRefreshToken();
  Future<Result<void>> clearTokens();
}

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage secureStorage;

  const TokenStorageImpl({required this.secureStorage});

  @override
  Future<Result<void>> saveTokenPair(TokenPair tokenPair) async {
    try {
      secureStorage.write(key: "access_token", value: tokenPair.access);
      secureStorage.write(key: "refresh_token", value: tokenPair.refresh);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<TokenPair>> loadTokenPair() async {
    try {
      final access = await secureStorage.read(key: "access_token");
      if (access == null) {
        return Result.error(Exception("Missing Access Token"));
      }
      final refresh = await secureStorage.read(key: "refresh_token");
      if (refresh == null) {
        return Result.error(Exception("Missing Refresh Token"));
      }
      final tokenPair = TokenPair(access: access, refresh: refresh);
      return Result.ok(tokenPair);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<String>> loadAccessToken() async {
    try {
      final access = await secureStorage.read(key: "access_token");
      if (access == null) {
        return Result.error(Exception("Missing Access Token"));
      }
      return Result.ok(access);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<String>> loadRefreshToken() async {
    try {
      final refresh = await secureStorage.read(key: "access_token");
      if (refresh == null) {
        return Result.error(Exception("Missing Refresh Token"));
      }
      return Result.ok(refresh);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> clearTokens() async {
    try {
      await secureStorage.delete(key: "access_token");
      await secureStorage.delete(key: "refresh_token");
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
