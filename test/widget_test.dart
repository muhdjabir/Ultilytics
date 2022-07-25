// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbital_ultylitics/main.dart';
import 'package:orbital_ultylitics/screens/LoginScreen.dart';
import 'package:orbital_ultylitics/screens/NavigationBarScreen.dart';
import 'package:orbital_ultylitics/screens/SettingScreen.dart';
import 'package:orbital_ultylitics/screens/SignupScreen.dart';
import 'package:orbital_ultylitics/screens/customWidget/TeamNameWidget.dart';

void main() {
  group('Pre Login Widgets', () {
    testWidgets('Log In Page smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(Material(child: LoginScreen()));
      final captionFinder = find.text("Become the ultimate athlete");
      final registerFinder = find.text("Create new account!");
      final loginFinder = find.text("Login");
      final buttonFinder = find.byKey(ValueKey("loginButton"));
      final emailFinder = find.byKey(ValueKey("emailField"));
      final passwordFinder = find.byKey(ValueKey("passwordField"));

      // Verify that all texts and buttons are present
      expect(captionFinder, findsOneWidget);
      expect(registerFinder, findsOneWidget);
      expect(loginFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
    });

    testWidgets('Sign Up Page smoke test', (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          child: MaterialApp(home: SignupScreen()), data: MediaQueryData());
      await tester.pumpWidget(testWidget);

      final captionFinder = find.text("Create new account");
      final backFinder = find.text("Back to Login");
      final signUpFinder = find.text("Sign-up");
      final buttonFinder = find.byKey(ValueKey("signUpButton"));
      final emailFinder = find.byKey(ValueKey("emailField"));
      final passwordFinder = find.byKey(ValueKey("passwordField"));

      expect(captionFinder, findsOneWidget);
      expect(backFinder, findsOneWidget);
      expect(signUpFinder, findsOneWidget);
      expect(buttonFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
    });

    testWidgets('Setting Page smoke test', (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          child: MaterialApp(home: SettingsScreen()), data: MediaQueryData());
      await tester.pumpWidget(testWidget);

      final textFinder = find.text("Logout");

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Navigation Bar smoke test', (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          child: MaterialApp(
              home: NavigationBarScreen(
            index: 3,
          )),
          data: MediaQueryData());
      await tester.pumpWidget(testWidget);

      final historyFinder = find.byIcon(Icons.history_outlined);
      final teamsFinder = find.byIcon(Icons.group_outlined);
      final gamesFinder = find.byIcon(Icons.library_add_outlined);
      final settingsFinder = find.byIcon(Icons.settings);

      expect(historyFinder, findsOneWidget);
      expect(teamsFinder, findsOneWidget);
      expect(gamesFinder, findsOneWidget);
      expect(settingsFinder, findsOneWidget);
    });
  });
}
