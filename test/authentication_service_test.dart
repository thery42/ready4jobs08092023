import 'package:flutter_test/flutter_test.dart';
import 'package:ready4jobs/services/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // Appel de Firebase.initializeApp() avant d'exécuter les tests
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized(); // Assurez-vous que les widgets Flutter sont initialisés
    await Firebase.initializeApp();
  });

  group('AuthenticationService', () {
    test('signInWithEmail - successful sign-in', () async {
      final authService = AuthenticationService();
      final user = await authService.signInWithEmail('test@example.com', 'password');

      expect(user, isNotNull);
      // Ajoutez d'autres assertions si nécessaire
    });

    test('signInWithEmail - invalid email', () async {
      final authService = AuthenticationService();

      try {
        await authService.signInWithEmail('invalidemail', 'password');
        fail('Expected AuthenticationError.invalidEmail to be thrown.');
      } on AuthenticationError catch (error) {
        expect(error, AuthenticationError.invalidEmail);
      }
    });

    // Ajoutez d'autres tests pour les différents cas
  });
}
