
import 'package:flutter_test/flutter_test.dart';

import 'package:trackizer/main.dart';
import 'package:trackizer/view/splash/splash_screen.dart';

void main() {
  testWidgets('app shows splash screen on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const Trackizer());

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
