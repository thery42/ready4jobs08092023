// Cette classe contient des méthodes statiques pour valider les champs de formulaire couramment utilisés tels que l'e-mail et le mot de passe.
// Chaque méthode prend en entrée la valeur du champ de formulaire à valider et renvoie un message d'erreur s'il y a une validation échouée.
// Par exemple, la méthode 'validateEmail' vérifie si l'e-mail est vide et renvoie un message "Veuillez entrer un email" en cas d'échec.
// Si la valeur du champ est valide, la méthode renvoie 'null', ce qui indique qu'il n'y a pas d'erreur de validation.
// Vous pouvez ajouter d'autres vérifications à ces méthodes si nécessaire, par exemple pour vérifier le format de l'e-mail
// ou la longueur du mot de passe, en utilisant des expressions régulières ou des conditions supplémentaires.
// Cette classe est utile pour centraliser les règles de validation et les réutiliser dans différents formulaires de l'application.


class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un email';
    }
    // Ajoutez d'autres vérifications si nécessaire, par exemple pour le format de l'email
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    // Ajoutez d'autres vérifications si nécessaire, par exemple pour la longueur du mot de passe
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }
    if (confirmPassword != password) {
      return 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
    }
    return null;
  }
}
