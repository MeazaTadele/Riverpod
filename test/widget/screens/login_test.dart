import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/presentation/screens/login.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('login...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LogInPage(),
    ));

    final ctr = find.text('Log In');
    expect(ctr, findsNWidgets(2));
  });
  testWidgets('Email and password fields are present', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogInPage(),
      ),
    );
    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextFormField, 'Password');

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
  });
  testWidgets('Log In button has correct color', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogInPage(),
      ),
    );

    final logInButton = find.widgetWithText(ElevatedButton, 'Log In');
    final buttonWidget = await tester.widget(logInButton) as ElevatedButton;
    final buttonStyle = buttonWidget.style;

    if (buttonStyle != null) {
      expect(buttonStyle.backgroundColor!.resolve({}), Colors.blue);
    } else {
      fail('Button style is null');
    }
  });
  testWidgets('I do not have an account text is present', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogInPage(),
      ),
    );

    final noAccountText = find.text('I do not have account');

    expect(noAccountText, findsOneWidget);
  });
  testWidgets(
      'Log In button is enabled when both email and password fields are filled',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LogInPage(),
      ),
    );

    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    final logInButton = find.byType(ElevatedButton).first;

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');

    await tester.pump(); // Pump the widget tree to update the button's state

    final buttonWidget = await tester.widget(logInButton) as ElevatedButton;
    expect(buttonWidget.enabled, true);
  });

  // testWidgets('Log In button navigates to home page when pressed',
  //     (tester) async {
  //   final navigatorKey = GlobalKey<NavigatorState>();

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       navigatorKey: navigatorKey,
  //       home: LogInPage(),
  //       routes: {
  //         '/home': (context) => HomeScreen(), // Add this route
  //       },
  //     ),
  //   );

  //   final logInButton = find.widgetWithText(ElevatedButton, 'Log In');

  //   await tester.tap(logInButton);

  //   await tester.pumpAndSettle(); // Wait for the navigation to complete

  //   expect(navigatorKey.currentState!.canPop, true);

  //   // Get the current route
  //   ModalRoute<dynamic>? currentRoute =
  //       ModalRoute.of(navigatorKey.currentState!.context!);
  //   expect(currentRoute?.settings.name, '/home');
  // });
}
