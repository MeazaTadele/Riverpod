import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/presentation/screens/detailpage.dart';
import 'package:go_router/go_router.dart';

void main() {
  Uint8List getValidImage() {
  return Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48,
    0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00,
    0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78,
    0xDA, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
    0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
  ]);
}

final mockPost = Post(
  id: '1',
  description: 'Test description',
  image: getValidImage(),  // Valid image data
);

  testWidgets('AppBar title is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.text('Item'), findsOneWidget);
  });

  testWidgets('Image is displayed in Hero widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.byType(Hero), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Description text is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.text('Test description'), findsOneWidget);
  });

  testWidgets('View Comments button is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('View Comments button navigates to correct route',
      (WidgetTester tester) async {
    final router = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, __) => ItemPage(item: mockPost)),
      GoRoute(
          path: '/comment/:id', builder: (_, __) => Container()), // Mock route
    ]);
    await tester.pumpWidget(MaterialApp.router(
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser));
    await tester.tap(find.text('View Comments'));
    await tester.pumpAndSettle();
    expect(router.location, '/comment/1');
  });

  testWidgets('Background color of the screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    final container = tester.firstWidget(find.byType(Scaffold)) as Scaffold;
    expect(container.backgroundColor, Colors.blue[100]);
  });

  testWidgets('Styling of the View Comments button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.style?.backgroundColor?.resolve({}), Colors.blue[400]);
  });

  testWidgets('Icon inside the View Comments button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.byIcon(Icons.comment), findsOneWidget);
  });

  testWidgets('Padding around the description text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    final padding = tester
        .widget<Padding>(find.widgetWithText(Padding, 'Test description'));
    expect(padding.padding, EdgeInsets.all(20));
  });

  testWidgets('Scrolling behavior of SingleChildScrollView',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ItemPage(item: mockPost)));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
