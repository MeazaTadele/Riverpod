import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/commentmodels.dart'; // Adjust the import path as needed

void main() {
  group('Comment Model Tests', () {
    test('Constructor initializes correctly', () {
      final id = '1';
      final userId = 'user1';
      final content = 'Test comment';
      final timestamp = DateTime.now();

      final comment = Comment(
        id: id,
        userId: userId,
        content: content,
        timestamp: timestamp,
      );

      expect(comment.id, id);
      expect(comment.userId, userId);
      expect(comment.content, content);
      expect(comment.timestamp, timestamp);
    });

    test('fromJson initializes correctly', () {
      final json = {
        'id': '1',
        'userId': 'user1',
        'content': 'Test comment',
        'timestamp': '2023-01-01T12:00:00Z',
      };

      final comment = Comment.fromJson(json);

      expect(comment.id, '1');
      expect(comment.userId, 'user1');
      expect(comment.content, 'Test comment');
      expect(comment.timestamp, DateTime.parse('2023-01-01T12:00:00Z'));
    });
  });
}