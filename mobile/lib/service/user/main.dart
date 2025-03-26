import 'package:dio/dio.dart';
import 'package:zuqui/core/result.dart';
import 'package:zuqui/service/user/model.dart';

abstract class UserSerice {
  Future<Result<User>> getCurrentUser();
}

class UserSericeImpl implements UserSerice {
  final Dio dio;

  const UserSericeImpl({required this.dio});

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final res = await dio.get("/me/profile");
      final user = User.fromJson(res.data);
      return Result.ok(user);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
