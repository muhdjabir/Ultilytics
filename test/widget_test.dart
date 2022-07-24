// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbital_ultylitics/main.dart';
import 'package:orbital_ultylitics/screens/LoginScreen.dart';

void main() {
  testWidgets('Log In Page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Material(child: LoginScreen()));
    final captionFinder = find.text("Become the ultimate athlete");
    final registerFinder = find.text("Create new account!");
    final loginFinder = find.text("Login");
    final buttonFinder = find.byKey(ValueKey("loginButton"));

    // Verify that our counter starts at 0.
    expect(captionFinder, findsOneWidget);
    expect(registerFinder, findsOneWidget);
    expect(loginFinder, findsOneWidget);
    expect(buttonFinder, findsOneWidget);
  });
}
