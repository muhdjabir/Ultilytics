import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:orbital_ultylitics/main.dart' as app;

void main() {
  group("App Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("full app test", (tester) async {
      await tester.runAsync(() async {
        //final FlutterExceptionHandler? originalOnError = FlutterError.onError;
        app.main();
        tester.pumpAndSettle();
        //FlutterError.onError = originalOnError;
      });
    });
  });
}
