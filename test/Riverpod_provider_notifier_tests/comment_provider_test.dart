import 'package:mockito/mockito.dart';
import 'package:flutter_project/mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flutter_project/models/commentmodels.dart';

import 'package:flutter_project/providers/commentprovider.dart';
void main() {
  // Set up mock repository
  final mockRepository = MockCommentRepository();

  final testComment = Comment(
    id: '1',
    postId: '1',
    content: 'Test Comment',
    createdAt: DateTime.now(),
  );

  group('CommentNotifier tests', () {
    test('fetchComments updates state with fetched comments', () async {
      // Arrange
      when(mockRepository.fetchComments('1'))
          .thenAnswer((_) async => [testComment]);

      final container = ProviderContainer(
        overrides: [
          commentRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      // Act
      final commentNotifier = container.read(commentNotifierProvider.notifier);
      await commentNotifier.fetchComments('1');

      // Assert
      expect(container.read(commentNotifierProvider), [testComment]);
    });

    test('addComment adds a new comment and updates state', () async {
      // Arrange
      final newCommentContent = 'New Comment';
      final postId = '1';
      when(mockRepository.addComment(postId, any, newCommentContent))
          .thenAnswer((_) async {});
      when(mockRepository.fetchComments(postId))
          .thenAnswer((_) async => [testComment]);

      final container = ProviderContainer(
        overrides: [
          commentRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      // Act
      final commentNotifier = container.read(commentNotifierProvider.notifier);
      await commentNotifier.addComment(postId, 'user_id', newCommentContent);

      // Assert
      expect(container.read(commentNotifierProvider), [testComment]);
    });
  });
}
