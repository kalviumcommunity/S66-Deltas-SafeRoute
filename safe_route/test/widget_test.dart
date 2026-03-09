import 'package:flutter_test/flutter_test.dart';

import 'package:safe_route/main.dart';

void main() {
  testWidgets('renders splash screen title', (WidgetTester tester) async {
    await tester.pumpWidget(const SafeRouteApp());

    expect(find.text('Safe Route'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
  });
}
