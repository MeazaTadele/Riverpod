import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';


// Import the classes to be tested
import 'package:flutter_project/providers/userprovider.dart'; // Adjust the import path
import 'package:flutter_project/models/usermodel.dart'; // Adjust the import path

void main() {
  group('UserNotifier Tests', () {
    test('updateUser - success', () {
      // Arrange
      final initialUser = User(
          id: '001',
          name: 'John Doe',
          email: 'john@example.com',
          password: 'secure123');
      final userNotifier = UserNotifier(initialUser);

      // Act
      userNotifier.updateUser(name: 'Jane Doe', email: 'jane@example.com');

      // Assert
      expect(userNotifier.state.name, 'Jane Doe');
      expect(userNotifier.state.email, 'jane@example.com');
      expect(userNotifier.state.password,
          'secure123'); // Ensure password remains unchanged
    });
  });

  group('UserProvider Tests', () {
    test('Initial state', () {
      // Arrange
      final container = ProviderContainer();

      // Act
      final user = container.read(userProvider);

      // Assert
      expect(user.id, '001');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'secure123');
    });

    test('State update', () {
      // Arrange
      final container = ProviderContainer();
      final newUser = User(
          id: '001',
          name: 'Jane Doe',
          email: 'jane@example.com',
          password: 'newPassword');

      // Act
      container
          .read(userProvider.notifier)
          .updateUser(name: 'Jane Doe', email: 'jane@example.com');

      // Assert
      print(container.read(userProvider).email);
      print(container.read(userProvider).id);
      print(container.read(userProvider).name);


      expect(container.read(userProvider).id, newUser.id);
    });
  });
}
