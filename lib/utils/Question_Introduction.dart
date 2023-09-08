import 'dart:math';

class IntroductionQuestions {
  static final List<String> questions = [
    "Pour commencer, pouvez-vous nous parler un peu de vous et de votre parcours professionnel ?",
    "Avant de plonger dans les détails, pourriez-vous partager comment vous avez entendu parler de notre entreprise et de ce poste ?",
    "Pour commencer, pouvez-vous nous expliquer ce qui vous a poussé à postuler  ?",
    "Pourriez-vous nous parler de quelques expériences clés de votre carrière qui vous ont conduit(e) à postuler aujourd'hui ?",
    "Pourriez-vous partager ce qui vous motive le plus dans le fait de rejoindre une nouvelle équipe et de contribuer à de nouveaux projets ?",
    "Pourriez-vous nous dire comment vous décririez votre approche de travail en équipe ?",
    "Pour commencer, pourriez-vous nous parler d'une réalisation professionnelle dont vous êtes particulièrement fier(ère) ?",
    "Pourriez-vous partager comment vos expériences passées se connectent avec ce que nous recherchons pour ce poste ?"
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

/*
"C'est un plaisir de vous rencontrer. Pourriez-vous nous raconter comment vous avez développé votre intérêt pour ce domaine ?",
"Avant d'entrer dans les détails, pourriez-vous nous donner un aperçu de vos compétences clés et de la manière dont vous pensez les appliquer dans ce rôle ?",
 */