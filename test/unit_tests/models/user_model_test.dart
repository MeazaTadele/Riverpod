// test/models/user_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/usermodel.dart'; // Adjust the import path as needed

void main() {
  group('User Model Tests', () {
    test('Constructor initializes correctly', () {
      final id = '1';
      final name = 'John Doe';
      final email = 'john.doe@example.com';
      final password =
          'password123'; // Note: Consider security implications in real applications

      final user = User(
        id: id,
        fullname: name,
        email: email,
        password: password,
      );

      expect(user.id, id);
      expect(user.fullname, name);
      expect(user.email, email);
      expect(user.password, password);
    });

    test('copyWith updates correctly', () {
      final user = User(
        id: '1',
        fullname: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
      );

      final updatedUser =
          user.copyWith(name: 'Jane Doe', email: 'jane.doe@example.com');

      expect(updatedUser.id, user.id);
      expect(updatedUser.fullname, 'Jane Doe');
      expect(updatedUser.email, 'jane.doe@example.com');
      expect(updatedUser.password,
          user.password); // Ensure password remains unchanged
    });

    test('copyWith with no arguments returns identical user', () {
      final user = User(
        id: '1',
        fullname: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
      );

      final identicalUser = user.copyWith();

      expect(identicalUser.id, user.id);
      expect(identicalUser.fullname, user.fullname);
      expect(identicalUser.email, user.email);
      expect(identicalUser.password, user.password);
    });
  });
}
