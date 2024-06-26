// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/providers/itemproviders.dart';  // Ensure this file has the correct provider setup
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class adminFeed extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);  // Watching the posts state managed by Riverpod

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Colors.white,
              letterSpacing: 1.3,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.white,
        ),
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: posts.length,
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                return GridItem(item: posts[index]);
              },
            ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Post item;

  GridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Define what happens when a card is tapped
        context.push('/admin_detail/${item.id}');

      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 1),
            Expanded(
              child: Image.memory(item.image,  // Ensure the image path is correctly managed
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.broken_image, size: 50));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Define what happens when the comment button is pressed
                    context.push('/admin_comment/${item.id}');

                  },
                  child: Icon(Icons.comment),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue[400]),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
