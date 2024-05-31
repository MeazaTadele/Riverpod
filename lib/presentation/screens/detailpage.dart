import 'package:flutter/material.dart';
import 'package:flutter_project/models/items_model.dart';
import 'package:go_router/go_router.dart'; // Make sure this contains the Post model

class ItemPage extends StatelessWidget {
  final Post item;

  ItemPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(
          child: Text('Item',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Colors.white,
              letterSpacing: 1.3,
            ),),
        ),
        
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView for better scroll behavior
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: Hero( // Use Hero widget for image transition animation
                tag: 'postImage${item.image}',
                child: Image.memory(item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                item.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  context.push('/comment/${item.id}');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.comment),
                    SizedBox(width: 10),
                    Text('View Comments')
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue[400],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
