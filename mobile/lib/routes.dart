import 'package:zuqui/present/auth/login.dart';
import 'package:zuqui/present/auth/verify_otp.dart';
import 'package:zuqui/present/home.dart';
import 'package:zuqui/present/splash.dart';

const initialRoute = "/auth/login";
var routes = {
  "/splash": (context) => Splash(),
  "/auth/login": (context) => Login(),
  "/auth/otp/verify": (context) => VerifyOTP(),
  "/home": (context) => Home(),
};
