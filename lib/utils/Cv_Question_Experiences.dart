import 'dart:math';

  class ExperiencesQuestionsCv {
  static List<String> questions = [
    "Quelles ont été vos fonctions au sein de \$Entreprise ?",
    "Pouvez-vous me parler de vos principales réalisations chez \$Entreprise ?",
    "Comment avez-vous contribué au succès de \$Entreprise ?",
    "Avez-vous eu à travailler en équipe ? Pouvez-vous me donner un exemple ?",
    "Quels étaient les défis auxquels vous avez été confronté chez \$Entreprise ? Comment les avez-vous surmontés ?",
    "Avez-vous déjà eu à gérer un projet important ? Pouvez-vous en parler ?",
    "Comment votre expérience chez \$Entreprise correspond-elle à ce que nous recherchons pour ce poste ?",
    "Avez-vous suivi une formation spécifique pendant votre expérience chez \$Entreprise ?",
    "Comment décririez-vous la culture d'entreprise chez \$Entreprise ?",
    "Avez-vous eu des responsabilités de leadership ou de gestion chez \$Entreprise ?",
    "Pouvez-vous me donner un exemple de situation où vous avez dû résoudre un conflit au travail chez \$Entreprise ?",
    "Avez-vous été impliqué dans des initiatives d'amélioration des processus chez \$Entreprise ?",
    "Comment gérez-vous la pression et les délais serrés dans un environnement professionnel ?",
    "Pouvez-vous me parler de votre plus grande réussite professionnelle chez \$Entreprise ?",
    "Avez-vous eu des expériences internationales ou de travail à l'étranger chez \$Entreprise ?",
    "Avez-vous connu des promotions ou évolutions de carrière chez \$Entreprise ? Pouvez-vous m'en parler ?",
    "Comment avez-vous progressé dans votre rôle chez \$Entreprise au fil du temps ?",
  ];

  static String genererQuestion(String entreprise) {
    final random = Random();
    int index = random.nextInt(questions.length);
    return questions[index].replaceAll('\$Entreprise', entreprise);
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
