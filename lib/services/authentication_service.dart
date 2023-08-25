  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:google_sign_in/google_sign_in.dart';

  enum AuthenticationError {
    invalidEmail,
    userNotFound,
    wrongPassword,
    weakPassword,
    emailAlreadyInUse,
    unknownError,
  }

  class AuthenticationService {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    Future<User?> signInWithEmail(String email, String password) async {
      try {
        if (!email.contains('@')) {
          throw AuthenticationError.invalidEmail;
        }

        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          throw AuthenticationError.userNotFound;
        } else if (e.code == 'wrong-password') {
          throw AuthenticationError.wrongPassword;
        } else {
          throw AuthenticationError.unknownError;
        }
      }
    }
    Future<void> signOut() async {
      try {
        await _firebaseAuth.signOut();
        await _googleSignIn.signOut();  // Si vous voulez également déconnecter Google SignIn
      } catch (e) {
        print('Erreur lors de la déconnexion : $e');
        throw e;  // Vous pouvez choisir de gérer l'erreur différemment
      }
    }

    Future<User?> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          return null;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        throw AuthenticationError.unknownError;
      }
    }

    Future<User?> signUpWithEmail(String email, String password) async {
      try {
        if (!email.contains('@')) {
          throw AuthenticationError.invalidEmail;
        }

        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw AuthenticationError.weakPassword;
        } else if (e.code == 'email-already-in-use') {
          throw AuthenticationError.emailAlreadyInUse;
        } else {
          throw AuthenticationError.unknownError;
        }
      }
    }

    Future<void> sendPasswordResetEmail(String email) async {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        print('Password reset email sent.');
      } catch (e) {
        print('Error sending password reset email: $e');
      }
    }

    Future<User?> getCurrentUser() async {
      return _firebaseAuth.currentUser;
    }

    Future<void> resetPassword(String email) async {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        // Afficher un message de succès ou naviguer vers la page de connexion par exemple :
        // Navigator.pop(context); // Navigue vers la page de connexion
      } catch (e) {
        // Gérer les erreurs si nécessaire
        print('Erreur lors de l\'envoi de l\'email de réinitialisation du mot de passe: $e');
      }
    }

    Future<bool> checkUserExistence(String email) async {
      try {
        List<String> signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
        return signInMethods.isNotEmpty;
      } catch (e) {
        print('Erreur lors de la vérification de l\'existence de l\'utilisateur : $e');
        return false;
      }
    }

    Future<String?> signInUserWithEmailAndPassword(String email, String password) async {
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = userCredential.user;
        if (user != null) {
          if (!user.emailVerified) {
            return 'Veuillez vérifier votre e-mail avant de vous connecter.';
          }

          // Rest of the code for successful login...
          // ...

          return null; // Return null for success
        } else {
          return 'Utilisateur introuvable.';
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          return 'L\'adresse e-mail est mal formatée.';
        } else {
          return 'Erreur lors de la connexion de l\'utilisateur';
        }
      } catch (e) {
        print('Erreur lors de la connexion de l\'utilisateur');
        return 'Erreur lors de la connexion de l\'utilisateur';
      }
    }

    Future<void> resendConfirmationEmail() async {
      try {
        User? user = _firebaseAuth.currentUser;
        if (user != null) {
          await user.sendEmailVerification();
          // Vous pouvez également afficher un message de succès ici si nécessaire.
        }
      } catch (e) {
        print('Erreur lors du renvoi de l\'e-mail de confirmation : $e');
        // Vous pouvez afficher un message d'erreur ici si nécessaire.
      }
    }
  }
