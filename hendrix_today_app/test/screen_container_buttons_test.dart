import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hendrix_today_app/main.dart';

void main() {
  testWidgets('Screen Container has 4 buttons', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ScreenContainer())));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsNWidgets(4));
  });

  testWidgets('Pressing Home Button directs to HomePage', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ScreenContainer())));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("HomeButton")));
    await tester.pump();
  });
}
