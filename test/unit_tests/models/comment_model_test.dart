import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/commentmodels.dart'; // Adjust the import path as needed

void main() {
  group('Comment Model Tests', () {
    test('Constructor initializes correctly', () {
      final id = '1';
      final postId = 'user1';
      final content = 'Test comment';
      final createdAt = DateTime.now();

      final comment = Comment(
        id: id,
        postId: postId,
        content: content,
        createdAt: createdAt,
      );

      expect(comment.id, id);
      expect(comment.postId, postId);
      expect(comment.content, content);
      expect(comment.createdAt, createdAt);
    });

    test('fromJson initializes correctly', () {
      final json = {
        'id': '1',
        'postId': 'user1',
        'content': 'Test comment',
        'createdAt': '2023-01-01T12:00:00Z',
      };

      final comment = Comment.fromJson(json);

      expect(comment.id, '');
      expect(comment.postId, 'user1');
      expect(comment.content, 'Test comment');
      expect(comment.createdAt, DateTime.parse('2023-01-01T12:00:00Z'));
    });
  });
}
