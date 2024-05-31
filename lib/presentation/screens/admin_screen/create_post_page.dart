import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_project/providers/itemproviders.dart'; // Make sure this import points to your actual provider file
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateProvider<String>((ref) => '');

class adminAddPost extends ConsumerWidget {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ref.watch(imageProvider);  // Watch for changes in the image URL

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: const Center(child: Text('Create Post', style: TextStyle(color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              TextFormField(
                controller: descriptionController,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 30),
              AttachImageButton(),  // Custom widget to attach an image
              if (imageUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.file(File(imageUrl), width: 100, height: 100, fit: BoxFit.cover),
                ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (descriptionController.text.isEmpty || imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a description and attach an image.')));
                    return;
                  }
                  try {
                    Uint8List imageData = await File(imageUrl).readAsBytes();
                    await ref.read(postProvider.notifier).createPost(descriptionController.text, imageData);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post created successfully!')));

                    // Clear the form fields after successful post creation
                    descriptionController.clear();
                    ref.read(imageProvider.notifier).state = '';
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload post: $e')));
                  }
                },
                child: Text('Upload Post'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[400],
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttachImageButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          ref.read(imageProvider.notifier).state = image.path;  // Update the state provider with the new image path
        }
      },
      icon: const Icon(Icons.add),
      label: const Text('Attach an Image'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        side: BorderSide(width: 1.0, color: Colors.blue),
        padding: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
