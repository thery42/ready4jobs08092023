  class FormValidator {
    static String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer une adresse e-mail.';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
        return 'Adresse e-mail invalide.';  // Message d'erreur pour une adresse e-mail invalide
      }
      return null;
    }

    static String? validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer un mot de passe';
      }

      return null;
    }

    static String? validateLoginEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer votre adresse e-mail';
      }

      return null;
    }

    static String? validateLoginPassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer votre mot de passe';
      }

      return null;
    }
  }
