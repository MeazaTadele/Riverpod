import 'package:flutter_project/models/usermodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier(User user) : super(user);

  void updateUser({String? name, String? email, String? password}) {
    state = state.copyWith(name: name, email: email, password: password);
  }
}
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  // Initialize with default user or fetch from secure storage
  return UserNotifier(User(id: '001', fullname: 'John Doe', email: 'john@example.com', password: 'secure123'));
});
