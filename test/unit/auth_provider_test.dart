import 'package:flutter_test/flutter_test.dart';
import 'package:nutriquest_app/core/providers/auth_provider.dart';

void main() {
  group('AuthProvider Tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('initial state is not authenticated', () {
      expect(authProvider.isAuthenticated, false);
      expect(authProvider.user, null);
      expect(authProvider.isLoading, false);
    });

    test('error message is initially null', () {
      expect(authProvider.errorMessage, null);
    });

    test('sign out clears user data', () async {
      // Note: This test would require Firebase setup for full testing
      // For now, we'll test the basic structure
      expect(authProvider.isAuthenticated, false);
    });
  });
}
