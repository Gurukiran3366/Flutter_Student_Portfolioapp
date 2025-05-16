import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robokalam_app/main.dart';

void main() {
  testWidgets('App launches and shows SplashScreen', (WidgetTester tester) async {
    // Build your app
    await tester.pumpWidget(const RobokalamApp());

    // Wait for splash screen to render
    await tester.pump(); // 1st frame
    expect(find.text('Robokalam'), findsOneWidget); // Text in SplashScreen

    // Optionally wait for the timer (2 sec splash duration)
    await tester.pump(const Duration(seconds: 2));
  });
}
