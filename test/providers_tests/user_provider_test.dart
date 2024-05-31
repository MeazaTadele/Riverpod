import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import your User model
import 'package:flutter_project/models/usermodel.dart';
import 'package:flutter_project/providers/authprovider.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_project/mocks.mocks.dart';

// Import the generated mockito mocks
void main() {
  // Set up mock repository
  final mockRepository = MockAuthRepository();

  group('AuthNotifier tests', () {
    test('login updates state with token on success', () async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(authNotifierProvider.notifier);

      // Mock repository behavior
      when(mockRepository.login('test@example.com', 'password123')).thenAnswer(
          (_) async => {'token': 'mock_token', 'userId': 'mock_user_id'});

      // Act
      await notifier.login('test@example.com', 'password123');

      // Assert
      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.token, null);
      expect(notifier.state.userId, null);
    });

    test('login resets state on failure', () async {
      // Arrange
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(authNotifierProvider.notifier);

      // Mock repository behavior to throw an exception
      when(mockRepository.login(any, any)).thenThrow(Exception('Login failed'));

      // Act
      await notifier.login('invalid_email', 'invalid_password');

      // Assert
      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.token, isNull);
      expect(notifier.state.userId, isNull);
    });
  });
}
