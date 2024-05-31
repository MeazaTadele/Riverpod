import 'package:flutter/material.dart';
import 'package:flutter_project/providers/authnotifier.dart';
import 'package:flutter_project/providers/authprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsPage extends ConsumerStatefulWidget {
const UserDetailsPage({Key? key}) : super(key: key);

@override
_UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends ConsumerState<UserDetailsPage> {
bool isEditing = false;
late TextEditingController nameController;
late TextEditingController emailController;
TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

@override
void initState() {
super.initState();
nameController = TextEditingController();
emailController = TextEditingController();
}

@override
void dispose() {
nameController.dispose();
emailController.dispose();
newPasswordController.dispose();
confirmPasswordController.dispose();
super.dispose();
}

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
        print('User data: $user');

        if (!isEditing) {
          nameController.text = user['fullname'] ?? 'No Name';
          emailController.text = user['email'] ?? 'No Email';
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Full Name', nameController, isEditing),
              buildTextField('Email', emailController, isEditing),
              if (isEditing) buildPasswordField('New Password', newPasswordController),
              if (isEditing) buildPasswordField('Confirm New Password', confirmPasswordController),
              if (isEditing) buildActionButtons(context, authNotifier),
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

Widget buildTextField(String label, TextEditingController controller, bool enabled) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 8.0),
child: TextField(
controller: controller,
decoration: InputDecoration(
labelText: label,
border: enabled ? OutlineInputBorder() : InputBorder.none,
enabled: enabled,
),
),
);
}

Widget buildPasswordField(String label, TextEditingController controller) {
return TextField(
controller: controller,
obscureText: true,
decoration: InputDecoration(
labelText: label,
border: OutlineInputBorder(),
),
);
}

Widget buildActionButtons(BuildContext context, AuthNotifier authNotifier) {
return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
ElevatedButton(
onPressed: () async {
if (newPasswordController.text == confirmPasswordController.text) {
try {
await authNotifier.updateUserDetails(
nameController.text,
emailController.text,
newPasswordController.text,
);
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
setState(() { isEditing = false; });
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed: $e')));
}
} else {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match!')));
}
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
);
}
}