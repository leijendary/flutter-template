// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:template/main.dart' as app;
import 'package:template/utils/constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Sign in", (tester) async {
    await app.main();

    await tester.pumpAndSettle();

    final phoneNumberField = find.byKey(Keys.phoneNumber);

    expect(phoneNumberField, findsOneWidget);

    await tester.enterText(phoneNumberField, "000000000");

    expect(phoneNumberField, greaterThanOrEqualTo("000000000"));
  });
}
