import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/main.dart';

void main() {
  testWidgets('Home menu shows both lab topics', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Week 11 — Lab Manual'), findsOneWidget);
    expect(find.text('1. Shared Preferences'), findsOneWidget);
    expect(find.text('2. Firebase'), findsOneWidget);
  });
}
