import 'package:mockito/mockito.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:typed_data';

import 'package:flutter_project/models/commentmodels.dart';

import 'package:flutter_project/providers/itemproviders.dart';

void main() {
  final mockRepository = MockPostRepository();

  final testPost = Post(
    id: '1',
    image: Uint8List.fromList([]), // or other sample data
    description: 'Test Post',
    comments: [],
  );

  group('PostNotifier tests', () {
    test('fetchPosts updates state with fetched posts', () async {
      // Arrange
      when(mockRepository.fetchPosts()).thenAnswer((_) async => [testPost]);

      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      // Act
      final postNotifier = container.read(postProvider.notifier);
      await postNotifier.fetchPosts();

      // Assert
      expect(container.read(postProvider), [testPost]);
    });

    test('createPost adds a new post and updates state', () async {
      // Arrange
      final newPostDescription = 'New Post';
      final newPostImageData = Uint8List.fromList([]);
      when(mockRepository.createPost(newPostDescription, newPostImageData))
          .thenAnswer((_) async {});
      when(mockRepository.fetchPosts()).thenAnswer((_) async => [testPost]);

      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      // Act
      final postNotifier = container.read(postProvider.notifier);
      await postNotifier.createPost(newPostDescription, newPostImageData);

      // Assert
      expect(container.read(postProvider), [testPost]);
    });

    test('addCommentToPost adds a comment to the correct post', () {
      // Arrange
      final newComment = Comment(
        id: '1',
        postId: '1',
        content: 'New Comment',
        createdAt: DateTime.now(),
      );
      final postWithComment = Post(
        id: '1',
        image: Uint8List.fromList([]), // or other sample data
        description: 'Test Post',
        comments: [newComment],
      );

      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final postNotifier = container.read(postProvider.notifier);
      container.read(postProvider.notifier).state = [testPost];

      // Act
      postNotifier.addCommentToPost('1', newComment);

      // Assert
      print(container.read(postProvider));
      print("egdhjksla;dkjfks");
      final actualPosts = container.read(postProvider);
      expect(actualPosts.length,
          1); // Ensure there is exactly one post in the list
      expect(actualPosts[0].id, '1');
      expect(actualPosts[0].description, 'Test Post');
      expect(actualPosts[0].comments.length,
          1); // Ensure there is exactly one comment in the post
      expect(actualPosts[0].comments[0].id, newComment.id);
      expect(actualPosts[0].comments[0].postId, newComment.postId);
      expect(actualPosts[0].comments[0].content, newComment.content);
      // Optionally compare createdAt if needed
    });
  });
}
