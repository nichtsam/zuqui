import 'package:zuqui/present/auth/pages/login.dart';
import 'package:zuqui/present/auth/pages/verify_otp.dart';
import 'package:zuqui/present/home/pages/home.dart';
import 'package:zuqui/present/splash/pages/splash.dart';

const initialRoute = "/splash";
var routes = {
  "/splash": (context) => Splash(),
  "/auth/login": (context) => Login(),
  "/auth/otp/verify": (context) => VerifyOTP(),
  "/home": (context) => Home(),
};
