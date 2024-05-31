import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/presentation/screens/login.dart';
import 'package:flutter_project/presentation/widgets/nav.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_project/providers/authprovider.dart';
import 'package:flutter_project/providers/authnotifier.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockAuthNotifier extends Mock implements AuthNotifier {}

void main() {
  group('LogInPage Tests', () {
    late MockAuthNotifier mockAuthNotifier;

    setUp(() {
      mockAuthNotifier = MockAuthNotifier();
    });
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
