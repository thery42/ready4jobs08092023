import 'dart:math';

class CompetencesQuestionsCv {
  static List<String> questions = [
    "Comment avez-vous mis en place le/la \$competence dans votre entreprise ?",
    "Pouvez-vous me donner un exemple où vous avez utilisé le \$competence ?",
    "Quel a été votre projet le plus dur avec le \$competence ?",
    "Comment le \$competence a-t-il aidé votre équipe ou entreprise ?",
    "Avez-vous déjà enseigné le \$competence à quelqu'un ? Comment ?",
    "Comment savez-vous que vous êtes bon en \$competence ?",
    "Quelqu'un a-t-il déjà critiqué votre compétence en \$competence ? Que avez-vous fait ?",
    "Quels outils utilisez-vous avec le \$competence ?",
    "Comment restez-vous à jour en \$competence ?",
    "Avez-vous utilisé le \$competence dans différents domaines ? Comment ?",
    "Quelle est la chose la plus innovante que vous ayez faite avec le \$competence ?"
  ];

  static String genererQuestion(String competence) {
    final random = Random();
    int index = random.nextInt(questions.length);
    return questions[index].replaceAll('\$competence', competence);
  }
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
