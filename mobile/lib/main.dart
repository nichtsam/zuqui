import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zuqui/core/config/app.dart';
import 'package:zuqui/core/config/theme.dart';
import 'package:zuqui/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfig.name,
        theme: AppTheme.themeData,
        initialRoute: initialRoute,
        routes: routes);
  }
}
