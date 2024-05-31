// test/models/post_test.dart
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/commentmodels.dart';
import 'package:flutter_project/models/items_model.dart';

void main() {
  group('Post Model Tests', () {
    test('Constructor initializes correctly', () {
      final id = '1';
      final description = 'Test description';
      final image = Uint8List.fromList([1, 2, 3]);
      final comments = [
        Comment(
          id: 'c1',
          userId: 'u1',
          content: 'Comment 1',
          timestamp: DateTime.parse('2023-01-01T12:00:00Z'),
        ),
        Comment(
          id: 'c2',
          userId: 'u2',
          content: 'Comment 2',
          timestamp: DateTime.parse('2023-01-02T12:00:00Z'),
        ),
      ];

      final post = Post(
        id: id,
        description: description,
        image: image,
        comments: comments,
      );

      expect(post.id, id);
      expect(post.description, description);
      expect(post.image, image);
      expect(post.comments, comments);
    });

    test('fromJson initializes correctly with valid data', () {
      final json = {
        '_id': '1',
        'description': 'Test description',
        'picture': {
          'data': [1, 2, 3],
        },
        'comments': [
          {
            'id': 'c1',
            'userId': 'u1',
            'content': 'Comment 1',
            'timestamp': '2023-01-01T12:00:00Z',
          },
          {
            'id': 'c2',
            'userId': 'u2',
            'content': 'Comment 2',
            'timestamp': '2023-01-02T12:00:00Z',
          },
        ],
      };

      final post = Post.fromJson(json);

      expect(post.id, '1');
      expect(post.description, 'Test description');
      expect(post.image, Uint8List.fromList([1, 2, 3]));
      expect(post.comments.length, 2);
      expect(post.comments[0].id, 'c1');
      expect(post.comments[0].userId, 'u1');
      expect(post.comments[0].content, 'Comment 1');
      expect(
          post.comments[0].timestamp, DateTime.parse('2023-01-01T12:00:00Z'));
      expect(post.comments[1].id, 'c2');
      expect(post.comments[1].userId, 'u2');
      expect(post.comments[1].content, 'Comment 2');
      expect(
          post.comments[1].timestamp, DateTime.parse('2023-01-02T12:00:00Z'));
    });

    test('fromJson initializes correctly with missing optional data', () {
      final json = {
        '_id': '1',
        'description': 'Test description',
      };

      final post = Post.fromJson(json);

      expect(post.id, '1');
      expect(post.description, 'Test description');
      expect(post.image, Uint8List(0));
      expect(post.comments.length, 0);
    });
  });
}
