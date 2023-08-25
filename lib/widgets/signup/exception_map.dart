// Cette classe contient une méthode statique pour mapper les codes d'erreur de Firebase Authentication
// vers des messages d'erreur explicites.
// La méthode 'getMessageFromErrorCode' prend en entrée un code d'erreur et renvoie un message associé
// à l'erreur spécifique. Par exemple, si le code d'erreur est 'invalid-email', la méthode renverra
// le message "Votre adresse e-mail semble mal formée.".
// La méthode utilise une instruction 'switch' pour associer chaque code d'erreur à un message correspondant,
// et si le code d'erreur n'est pas reconnu, elle renvoie un message générique "Une erreur inconnue est survenue. Veuillez réessayer."
// Cette classe est utile pour traiter et afficher des messages d'erreur compréhensibles en cas de problèmes liés à l'authentification.

class FirebaseAuthExceptionMap {
  static String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return "Votre adresse e-mail semble mal formée.";
      case 'user-disabled':
        return "Votre compte a été désactivé.";
      case 'user-not-found':
        return "Aucun utilisateur ne correspond à cette adresse e-mail.";
      case 'wrong-password':
        return "Votre mot de passe est incorrect.";
      case 'email-already-in-use':
        return "L'adresse e-mail est déjà enregistrée. Veuillez vous connecter.";
      case 'operation-not-allowed':
        return "La connexion avec e-mail et mot de passe n'est pas activée.";
      case 'weak-password':
        return "Votre mot de passe est trop faible. Il doit contenir au moins 8 caractères.";
      case 'too-many-requests':
        return "Trop de tentatives infructueuses de connexion. Veuillez réessayer plus tard.";
      default:
        return "Une erreur inconnue est survenue. Veuillez réessayer.";
    }
  }
}
