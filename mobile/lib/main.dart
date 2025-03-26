import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:zuqui/config/app.dart';
import 'package:zuqui/config/theme.dart';
import 'package:zuqui/core/env.dart';
import 'package:zuqui/core/network/auth_interceptor.dart';
import 'package:zuqui/routes.dart';
import 'package:zuqui/service/auth/main.dart';
import 'package:zuqui/service/auth/token.dart';
import 'package:zuqui/service/user/main.dart';
import 'package:zuqui/utils/snackbar.dart';

(AuthSerice, UserSerice) _setupService() {
  final baseDio = Dio(
    BaseOptions(
      baseUrl: Env.coreApiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 5),
    ),
  );
  baseDio.interceptors.add(LogInterceptor());

  baseDio.interceptors.add(
    RetryInterceptor(
      dio: baseDio,
      retryEvaluator:
          DefaultRetryEvaluator(
            defaultRetryableStatuses.toSet()..remove(status429TooManyRequests),
          ).evaluate,
    ),
  );

  final secureStorage = FlutterSecureStorage();
  final tokenStorage = TokenStorageImpl(secureStorage: secureStorage); // fix
  final authService = AuthSericeImpl(dio: baseDio, tokenStorage: tokenStorage);

  final appDio = baseDio.clone();
  appDio.interceptors.add(AuthInterceptor(dio: baseDio, auth: authService));

  final userService = UserSericeImpl(dio: appDio);

  return (authService, userService);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  final (authService, userService) = _setupService();

  GetIt.instance.registerSingleton(authService);
  GetIt.instance.registerSingleton(userService);

  runApp(MyApp(authService: authService, userService: userService));
}

class MyApp extends StatelessWidget {
  final AuthSerice authService;
  final UserSerice userService;
  const MyApp({
    super.key,
    required this.authService,
    required this.userService,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: AppConfig.name,
      theme: AppTheme.themeData,
      darkTheme: AppTheme.darkThemeData,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
