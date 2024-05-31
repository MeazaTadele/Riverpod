

import 'package:flutter/material.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:flutter_project/providers/itemproviders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WithAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider); 


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
        context.push('/detail/${item.id}');

      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 1),
            Expanded(
              child: Image.memory(
                item.image, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.broken_image, size: 50));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description,
                maxLines:1,
                textAlign: TextAlign.center,
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
                  
                    context.push('/comment/${item.id}');
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
