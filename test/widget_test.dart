import 'package:flutter_test/flutter_test.dart';
import 'package:johannpinheiro/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JohannApp());
    expect(find.byType(JohannApp), findsOneWidget);
  });
}
