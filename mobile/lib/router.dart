import 'package:go_router/go_router.dart';
import 'package:zuqui/present/auth/login.dart';
import 'package:zuqui/present/auth/verify_otp.dart';
import 'package:zuqui/present/home.dart';

final router = GoRouter(
  initialLocation: "/auth/login",
  routes: [
    GoRoute(path: "/home", builder: (context, state) => Home()),
    GoRoute(path: "/auth/login", builder: (context, state) => Login()),
    GoRoute(path: "/auth/otp/verify", builder: (context, state) => VerifyOTP()),
  ],
);
