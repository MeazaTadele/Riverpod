import 'package:flutter/material.dart';
import 'package:flutter_project/providers/authprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class adminprofile extends ConsumerStatefulWidget {
  const adminprofile({Key? key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends ConsumerState<adminprofile> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();  // For entering a new password
  TextEditingController confirmPasswordController = TextEditingController();  // For confirming the new password

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.cancel : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                // Clear password fields when toggling editing mode
                newPasswordController.clear();
                confirmPasswordController.clear();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: authNotifier.fetchUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            print('User data: $user'); // Debugging statement

            final userFullName = user['fullname'] ?? 'No Name';
            final userEmail = user['email'] ?? 'No Email';

            nameController.text = userFullName;
            emailController.text = userEmail;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: isEditing ? OutlineInputBorder() : InputBorder.none,
                      enabled: isEditing,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: isEditing ? OutlineInputBorder() : InputBorder.none,
                      enabled: isEditing,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (isEditing)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm New Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  if (isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Ensure passwords match before updating
                            if (newPasswordController.text == confirmPasswordController.text) {
                              await authNotifier.updateUserDetails(
                                nameController.text,
                                emailController.text,
                                newPasswordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile updated successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Passwords do not match!')),
                              );
                            }
                            setState(() {
                              isEditing = false;
                            });
                          },
                          child: Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = false;
                            });
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data found.'));
          }
        },
      ),
    );
  }
}
