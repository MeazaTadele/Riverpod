import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:your_app_name/main.dart'; // replace with your actual app file
import 'package:flutter_project/models/commentmodels.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/repositories/api_post_repository.dart';
import 'package:flutter_project/repositories/post_repositories.dart';
void main() {
  testWidgets('Test post widget', (WidgetTester tester) async {
    // Step 4: Create a ProviderContainer
    final container = ProviderContainer();

    // Override any providers as needed
    container.register(ApiPostRepository((_) => ApiPostRepository()));
    container.overrideProvider(postProvider, <Post>[]);

    // Step 5: Write your widget test
    await tester.pumpWidget(
      ProviderScope(
        container: container,
        child: PostWidget(), // replace with your actual widget
      ),
    );

    // Verify that the widget is rendered correctly
    expect(find.text('No posts yet'), findsOneWidget);

    // Perform an action to fetch posts
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify that the posts were fetched
    expect(find.text('Post 1'), findsOneWidget);

    // Perform an action to create a new post
    await tester.enterText(find.byType(TextFormField), 'New post description');
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verify that the new post was created
    expect(find.text('New post description'), findsOneWidget);

    // Clean up after the test
    container.dispose();
  });
}