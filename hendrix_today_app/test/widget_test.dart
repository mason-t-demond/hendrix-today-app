import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hendrix_today_app/home_screen.dart';
import 'package:hendrix_today_app/calendar_screen.dart';
import 'package:hendrix_today_app/search_screen.dart';

void main() {
  testWidgets('Home Screen is populated', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomeScreen()));
    await tester.pumpAndSettle();

    expect(find.byWidget(Image.asset('assets/banner.png')), findsOneWidget);
    expect(find.byType(Card), findsAtLeastNWidgets(1));
  });

  testWidgets('Calendar Screen is populated', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CalendarScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(EventCalendar), findsOneWidget);
  });

  testWidgets('Search Screen exists and has searchBar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SearchScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(AnimSearchBar), findsOneWidget);
  });
}
