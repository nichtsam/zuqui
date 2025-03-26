import 'package:dio/dio.dart';
import 'package:zuqui/service/auth/main.dart';

class AuthInterceptor extends Interceptor {
  final AuthSerice auth;
  final Dio dio;

  AuthInterceptor({required this.dio, required this.auth});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.startsWith("/auth")) {
      final result = await auth.getAccessToken();
      result.match(
        onOk: (access) {
          options.headers['Authorization'] = 'Bearer $access';
        },
        onError: (_) {},
      );
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await auth.refreshTokenPair();
      final result = await auth.getAccessToken();

      result.match(
        onOk: (access) {
          err.requestOptions.headers['Authorization'] = 'Bearer $access';
        },
        onError: (_) {},
      );

      return handler.resolve(await dio.fetch(err.requestOptions));
    }

    return handler.next(err);
  }
}
