import 'dart:math';

class ComportementQuestions {
  static final List<String> questions = [
    "Racontez un projet à deadline serrée que vous avez mené à bien.",
    "Comment avez-vous géré un désaccord avec un collègue ?",
    "Comment avez-vous réagi à des retours négatifs ?",
    "Décrivez une situation où vous avez dû résoudre un problème urgent.",
    "Parlez d'une initiative d'amélioration que vous avez lancée.",
    "Comment avez-vous traité un client mécontent ?",
    "Comment avez-vous collaboré avec des collègues aux compétences différentes ?",
    "Racontez une décision prise avec peu d'informations.",
    "Comment avez-vous jonglé entre plusieurs tâches importantes ?",
    "Comment avez-vous aidé un collègue à comprendre un concept complexe ?",
    "Parlez d'une fois où vous avez dû gérer un changement inattendu.",
    "Comment avez-vous résolu un conflit entre membres d'équipe ?",
    "Racontez un succès que vous avez célébré en équipe.",
    "Décrivez comment vous avez motivé vos collègues dans un moment difficile.",
    "Comment avez-vous géré une charge de travail excessive ?",
    "Parlez d'un moment où vous avez pris une initiative sans être sollicité.",
    "Comment avez-vous adapté votre communication à un public varié ?",
    "Décrivez une situation où vous avez dû respecter des normes de qualité élevées.",
    "Comment avez-vous négocié avec un fournisseur ou un partenaire ?",
    "Racontez comment vous avez appris rapidement pour relever un défi nouveau.",
    "Parlez d'une situation où vous avez dû convaincre d'autres personnes de votre point de vue.",
    "Comment avez-vous géré une période de stress intense au travail ?",
    "Décrivez comment vous avez contribué à une amélioration de l'efficacité au sein de votre équipe.",
    "Parlez d'une expérience où vous avez assumé un rôle de leadership de facto.",
    "Comment avez-vous géré un défi lié à la communication interculturelle ?",
    "Décrivez comment vous avez géré une erreur que vous avez commise.",
    "Racontez comment vous avez favorisé un environnement de travail inclusif.",
    "Parlez d'une situation où vous avez dû prendre une décision impopulaire.",
    "Comment avez-vous géré une période de changement organisationnel ?"
  ];

  static String lastQuestion = "";

  static String getRandomQuestion() {
    final Random random = Random();
    String randomQuestion;
    do {
      randomQuestion = questions[random.nextInt(questions.length)];
    } while (randomQuestion == lastQuestion);
    lastQuestion = randomQuestion;
    return randomQuestion;
  }
}