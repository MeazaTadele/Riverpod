// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_project/providers/authnotifier.dart'; 
// import 'package:flutter_project/providers/authprovider.dart'; // Adjust the import based on your file structure
// import 'package:flutter_project/repositories/auth_repository.dart'; // Adjust the import based on your file structure
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:mocktail/mocktail.dart'; // For mocking HTTP requests
// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   group('AuthNotifier', () {
//     late ProviderContainer container;
//     late AuthNotifier authNotifier;
//     late MockAuthRepository mockAuthRepository;

//     setUp(() {
//       // Create a new container before each test
//       container = ProviderContainer();
//       // Mock AuthRepository
//       mockAuthRepository = MockAuthRepository();
//       // Provide mockAuthRepository to the provider
//       container.read(authRepositoryProvider).overrideWithValue(mockAuthRepository);
//       // Initialize AuthNotifier
//       authNotifier = AuthNotifier(mockAuthRepository);
//     });

//     tearDown(() {
//       // Dispose of the container after each test
//       container.dispose();
//     });

//     test('Login success updates auth state', () async {
//       // Arrange
//       const mockToken = 'mock_token';
//       when(() => mockAuthRepository.login(any(), any())).thenAnswer((_) async => mockToken);

//       // Act
//       await authNotifier.login('test@example.com', 'password');

//       // Assert
//       expect(authNotifier.state, equals(AuthState.authenticated(mockToken)));
//     });

//     test('Login failure throws exception', () async {
//       // Arrange
//       when(() => mockAuthRepository.login(any(), any())).thenThrow(Exception('Failed to login'));

//       // Act & Assert
//       expect(() async => await authNotifier.login('invalid@example.com', 'wrong_password'), throwsException);
//     });

//     // Similar tests can be written for signup, fetchUserDetails, and updateUserDetails

//   });
// }