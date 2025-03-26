import 'package:dio/dio.dart';
import 'package:zuqui/core/result.dart';
import 'package:zuqui/service/auth/main.dart';
import 'package:zuqui/utils/snackbar.dart';

Future<Result<void>> sendOTP(AuthSerice authService, String email) async {
  var result = await authService.sendOTP(email);
  return result.match(
    onOk: (_) {
      snackBar("✉️ An email has been sent!");
      return Result.ok(null);
    },
    onError: (error) {
      if (error is DioException && error.response?.statusCode == 429) {
        snackBar(
          "✉️ An email has already been sent. Please wait before requesting again.",
        );
        return Result.ok(null);
      }

      snackBar(
        "😬 Oops! Something went wrong. Please try again later, and let us know if the issue persists.",
      );
      return Result.error(error);
    },
  );
}
