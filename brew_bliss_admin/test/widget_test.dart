// Basic smoke test for Brew & Bliss Admin.

import 'package:flutter_test/flutter_test.dart';

import 'package:brew_bliss_admin/main.dart';

void main() {
  testWidgets('Admin app builds and shows login', (WidgetTester tester) async {
    await tester.pumpWidget(const BrewBlissAdminApp());

    expect(find.text('Welcome Back 👋'), findsOneWidget);
  });
}
