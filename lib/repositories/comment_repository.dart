// comment_repository.dart
import 'dart:convert';

import 'package:flutter_project/models/commentmodels.dart';
import 'package:http/http.dart' as http;


class CommentRepository {
  final String baseUrl;

  CommentRepository(this.baseUrl);

  Future<List<Comment>> fetchComments(String postId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/comments/$postId'));
  

      if (response.statusCode == 200) {
        final List<dynamic> commentsJson = json.decode(response.body);
        return commentsJson.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
  
      throw e;
    }
  }

  Future<void> addComment(String postId, String userId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/comments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'postId': postId,
          'userId': userId,
          'content': content,
        }),
      );


      if (response.statusCode != 201) {
        throw Exception('Failed to add comment');
      }
    } catch (e) {

      throw e;
    }
  }
}
