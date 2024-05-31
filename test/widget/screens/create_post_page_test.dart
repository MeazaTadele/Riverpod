import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/presentation/screens/create_post_page.dart'; // Adjust the import to match your project structure
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

// Mocking the ImagePicker
class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  final mockImagePicker = MockImagePicker();

  setUp(() {
    // Reset the image picker mock before each test
    reset(mockImagePicker);
  });

  testWidgets('AppBar title is displayed', (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    expect(find.text('Create Post'), findsOneWidget);
  });

  testWidgets('Description TextFormField is present',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Description'), findsOneWidget);
  });

  testWidgets('Attach Image button is present', (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    expect(find.widgetWithIcon(OutlinedButton, Icons.add), findsNothing);
    expect(find.text('Attach an Image'), findsOneWidget);
  });

  testWidgets('Upload Post button is present', (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Upload Post'), findsOneWidget);
  });

  testWidgets('Validation message when uploading without description and image',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    await tester.tap(find.text('Upload Post'));
    await tester.pump();
    expect(find.text('Please enter a description and attach an image.'),
        findsOneWidget);
  });

  testWidgets('Styling of the Upload Post button', (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.style?.backgroundColor?.resolve({}), Colors.blue[400]);
  });

  testWidgets('Scrolling behavior of SingleChildScrollView',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: LostFoundForm())));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
