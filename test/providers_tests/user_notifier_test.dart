import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:flutter_project/providers/comment_notifier.dart';
import 'package:flutter_project/repositories/comment_repository.dart';
import 'dart:convert';
import 'package:flutter_project/providers/itemproviders.dart';

// Import the classes to be tested
import 'package:flutter_project/providers/userprovider.dart'; // Adjust the import path
import 'package:flutter_project/models/usermodel.dart'; // Adjust the import path

class MockCommentRepository extends Mock implements CommentRepository {}

class MockHttpClient extends Mock implements http.Client {}

class MockClient extends Mock implements http.Client {}

void main() {
  group('UserNotifier Tests', () {
    test('updateUser - success', () {
      // Arrange
      final initialUser = User(
          id: '001',
          name: 'John Doe',
          email: 'john@example.com',
          password: 'secure123');
      final userNotifier = UserNotifier(initialUser);

      // Act
      userNotifier.updateUser(name: 'Jane Doe', email: 'jane@example.com');

      // Assert
      expect(userNotifier.state.name, 'Jane Doe');
      expect(userNotifier.state.email, 'jane@example.com');
      expect(userNotifier.state.password,
          'secure123'); // Ensure password remains unchanged
    });
  });

  group('UserProvider Tests', () {
    test('Initial state', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      final user = container.read(userProvider);

      // Assert
      expect(user.id, '001');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'secure123');
    });

    test('State update', () {
      // Arrange
      final container = ProviderContainer();
      final newUser = User(
          id: '001',
          name: 'Jane Doe',
          email: 'jane@example.com',
          password: 'newPassword');

      // Act
      container
          .read(userProvider.notifier)
          .updateUser(name: 'Jane Doe', email: 'jane@example.com');

      // Assert
      print(container.read(userProvider).email);
      print(container.read(userProvider).id);
      print(container.read(userProvider).name);

      expect(container.read(userProvider).id, newUser.id);
    });
  });

  group('CommentRepository', () {
    late MockHttpClient mockHttpClient;
    late CommentRepository commentRepository;

    setUp(() {
      mockHttpClient = MockHttpClient();
      commentRepository = CommentRepository('http://localhost:3003');
    });

    test('fetchComments - failure', () async {
      // Arrange
      final postId = '1';
      when(() => mockHttpClient
              .get(Uri.parse('http://localhost:3003/comments/$postId')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => commentRepository.fetchComments(postId), throwsException);
    });

    test('addComment - failure', () async {
      // Arrange
      final postId = '1';
      final userId = '1';
      final content = 'Great post!';
      when(() => mockHttpClient.post(
            Uri.parse('http://localhost:3003/comments'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'postId': postId,
              'userId': userId,
              'content': content,
            }),
          )).thenAnswer((_) async => http.Response('Error', 400));

      // Act & Assert
      expect(() => commentRepository.addComment(postId, userId, content),
          throwsException);
    });
  });
}
