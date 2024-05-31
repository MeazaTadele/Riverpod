// comment_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/commentprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentadminPage extends ConsumerStatefulWidget {
  final String postId;

  const CommentadminPage({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends ConsumerState<CommentadminPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(commentNotifierProvider.notifier).fetchComments(widget.postId);
  }

  Future<void> _addComment() async {
    final userId = 'current_user_id'; // Retrieve the current user's ID
    final content = _controller.text;
    await ref.read(commentNotifierProvider.notifier).addComment(widget.postId, userId, content);
    _controller.clear(); // Clear the input field after adding a comment
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: comments.isEmpty
                ? Center(child: Text('No comments yet.'))
                : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        title: Text(comment.content),
                        subtitle: Text(comment.createdAt.toString()),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Add a comment'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
