import 'package:flutter_test/flutter_test.dart';

import 'package:brew_bliss/main.dart';

void main() {
  testWidgets('App loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const BrewBlissApp());
    await tester.pump();

    expect(find.text('Brew & Bliss'), findsOneWidget);

    // Splash schedules a 3s navigation; advance time so no timers are pending.
    await tester.pump(const Duration(seconds: 4));
  });
}
