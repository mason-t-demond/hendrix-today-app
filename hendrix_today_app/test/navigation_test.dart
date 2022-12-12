import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hendrix_today_app/calendar_screen.dart';
import 'package:hendrix_today_app/home_screen.dart';
import 'package:hendrix_today_app/main.dart';
import 'package:hendrix_today_app/search_screen.dart';

//code for expecting a page found here: https://stackoverflow.com/a/51983194
//worked before firebase implementation

void main() {
  testWidgets('Screen Container has 4 buttons', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ScreenContainer())));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsNWidgets(4));
  });

  testWidgets('Button keys are set properly', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ScreenContainer())));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('HomeButton')), findsOneWidget);
    expect(find.byKey(const Key('CalendarButton')), findsOneWidget);
    expect(find.byKey(const Key('SearchButton')), findsOneWidget);
    expect(find.byKey(const Key('MenuButton')), findsOneWidget);
  });

  testWidgets('HomeButton directs to MyHomeScreen', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: ScreenContainer())));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("HomeButton")));
    await tester.pumpAndSettle();

    expect(find.byType(MyHomeScreen), findsOneWidget);
  });

  testWidgets('CalendarButton directs to CalendarScreen', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ScreenContainer()),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("CalendarButton")));
    await tester.pumpAndSettle();

    expect(find.byType(CalendarScreen), findsOneWidget);
  });

  testWidgets('SearchButton directs to SearchScreen', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ScreenContainer()),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("SearchButton")));
    await tester.pumpAndSettle();

    expect(find.byType(SearchScreen), findsOneWidget);
  });
}
