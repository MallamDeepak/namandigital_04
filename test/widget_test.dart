// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:quizapp/main.dart';

void main() {
  testWidgets('QuizApp launches and shows HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Brain Blaster Quiz'), findsOneWidget);
    expect(find.text('Lowest Score'), findsOneWidget);
    expect(find.text('Highest Score'), findsOneWidget);
  });

  testWidgets('Category button navigates to QuizScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('General Knowledge'));
    await tester.pumpAndSettle();
    expect(find.text('Question 1 of 10'), findsOneWidget);
  });

  testWidgets('QuizScreen answer selection and submit', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('General Knowledge'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Paris'));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pump();
    // Check that score updates after finishing quiz
  });
}
