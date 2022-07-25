import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver?.close();
    }
  });

  Future<bool> isPresent(SerializableFinder byValueKey,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver?.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  test('Navigate through the application', () async {
    /*if (await isPresent(signOutButton)) {
      await driver.tap(signOutButton);
    }*/

    // Go to Registration page
    final registrationButton = find.byValueKey("register");
    final backButton = find.byValueKey("backButton");

    await driver?.tap(registrationButton);
    await driver?.tap(backButton);

    // Log Into an Existing DEMO Account
    final registerFinder = find.text("Create new account!");
    final loginFinder = find.text("Login");
    final buttonFinder = find.byValueKey("loginButton");
    final emailFinder = find.byValueKey("emailField");
    final passwordFinder = find.byValueKey("passwordField");

    await driver?.waitFor(loginFinder);
    await driver?.tap(emailFinder);
    await driver?.enterText("demo@gmail.com");
    await driver?.tap(passwordFinder);
    await driver?.enterText("password");
    await driver?.tap(loginFinder);

    // View History Tabs
    final historyFinder = find.byValueKey("historyTab");
    await driver?.tap(historyFinder);

    // View Team History
    final teamHistory = find.byValueKey("teamHistory");

    // View Team tab
    final teamFinder = find.byValueKey("teamTab");
    await driver?.tap(teamFinder);

    // View Create New Game
    final gameFinder = find.byValueKey("gameTab");
    await driver?.tap(gameFinder);

    // Sign out of account
    final settingsFinder = find.byValueKey("settingsTab");
    await driver?.tap(settingsFinder);
    await driver?.tap(find.text("Logout"));
  });
}
