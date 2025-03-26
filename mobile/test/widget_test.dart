// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuqui/core/result.dart';
import 'package:zuqui/main.dart';
import 'package:zuqui/service/auth/main.dart';
import 'package:zuqui/service/user/main.dart';
import 'package:zuqui/service/user/model.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MyApp(authService: MockAuthService(), userService: MockUserService()),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

class MockAuthService implements AuthSerice {
  @override
  Future<Result<String>> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> loginOTP(String email, String otp) {
    // TODO: implement loginOTP
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> refreshTokenPair() {
    // TODO: implement refreshTokenPair
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> sendOTP(String email) {
    // TODO: implement sendOTP
    throw UnimplementedError();
  }
}

class MockUserService implements UserSerice {
  @override
  Future<Result<User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
