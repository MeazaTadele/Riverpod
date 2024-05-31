import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/repositories/auth_repository.dart';

void main() {
  testWidgets('Test user widget', (WidgetTester tester) async {
    // Step 4: Create a ProviderContainer
    final container = ProviderContainer();

    // Override any providers as needed
    container.register(AuthRepository((_) => AuthRepository('')));
    container.overrideProvider(userProvider, User(
      id: '001',
      name: 'John Doe',
      email: 'john@example.com',
      password: 'secure123'));

    // Step 5: Write your widget test
    await tester.pumpWidget(
      ProviderScope(
        container: container,
        child: UserWidget(), // replace with your actual widget
      ),
    );

    // Verify that the widget is rendered correctly
    expect(find.text('John Doe'), findsOneWidget);

    // Perform an action to update the user
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify that the user was updated
    expect(find.text('Jane Doe'), findsOneWidget);

    // Clean up after the test
    container.dispose();
  });
}