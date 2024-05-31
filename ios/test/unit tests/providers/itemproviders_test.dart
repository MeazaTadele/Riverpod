import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_project/providers/itemproviders.dart';
import 'package:flutter_project/repositories/post_repositories.dart';
import 'package:flutter_project/models/items_model.dart';

// Mock class for PostRepository
class MockPostRepository extends Mock implements PostRepository {
  @override
  Future<List<Post>> fetchPosts() async {
    // Stubbed implementation to return a list of posts
    return [
      Post(id: '1', description: 'Post 1', image: Uint8List(0), comments: [])
    ];
  }
}

void main() {
  group('PostNotifier Tests', () {
    late MockPostRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockPostRepository();
      container = ProviderContainer(overrides: [
        postRepositoryProvider.overrideWithValue(mockRepository),
      ]);
    });

    test('fetchPosts - success', () async {
      // Arrange
      final posts = [
        Post(id: '1', description: 'Post 1', image: Uint8List(0), comments: [])
      ];

      // Mocking fetchPosts to return a Future<List<Post>>
      when(mockRepository.fetchPosts()).thenAnswer((_) async => posts);

      final notifier = container.read(postProvider.notifier);

      // Act
      await notifier.fetchPosts();

      // Assert
      expect(notifier.state, equals(posts));
    });

    test('fetchPosts - error', () async {
      // Arrange
      // Mocking fetchPosts to throw an Exception
      when(mockRepository.fetchPosts())
          .thenThrow(Exception('Failed to fetch posts'));

      final notifier = container.read(postProvider.notifier);

      // Act & Assert
      await expectLater(notifier.fetchPosts(), completes);
      expect(notifier.state, equals([])); // State should remain empty on error
    });

    // Add more tests for other methods as needed
  });
}
