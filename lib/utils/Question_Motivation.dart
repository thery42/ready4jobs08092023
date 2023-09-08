import 'dart:math';

class MotivationQuestions {
  static final List<String> questions = [
    "Qu'est-ce qui vous attire dans ce poste et notre entreprise?",
    "Comment voyez-vous votre contribution ici?",
    "Avez-vous adapté à une nouvelle culture auparavant? Comment?",
    "Comment vos valeurs s'alignent-elles sur les nôtres?",
    "Décrivez un exemple de collaboration réussie.",
    "Comment gérez-vous le stress au travail?",
    "Avez-vous des questions sur notre culture?",
    "Quelle réalisation reflète vos valeurs?",
    "Comment poursuivez-vous l'apprentissage professionnel?",
    "Parlez d'une situation éthique gérée.",
    "Comment gérez-vous les désaccords en équipe?",
    "Comment avez-vous géré un échec?",
    "Quelles valeurs ne compromettriez-vous pas au travail?",
    "Comment contribueriez-vous à notre culture?",
    "Qu'est-ce qui vous inspire au travail?",
    "Comment pensez-vous que votre expérience s'aligne sur notre culture?",
    "Parlez-moi d'une collaboration mémorable dans votre carrière.",
    "Comment abordez-vous les défis professionnels au quotidien?",
    "Quelle valeur de notre entreprise vous attire le plus?",
    "Décrivez un moment où vous avez dû vous adapter rapidement.",
    "Quelle est votre approche pour maintenir une atmosphère de travail positive?",
    "Comment avez-vous contribué à l'amélioration d'une équipe précédente?",
    "Quel rôle joue la communication dans votre style de travail?",
    "Parlez-moi d'une décision professionnelle basée sur des valeurs."
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
