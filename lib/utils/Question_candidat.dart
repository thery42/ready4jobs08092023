import 'dart:math';

class CandidatQuestions {
  static final List<String> questions = [
    "Nous arrivons au terme de cette simulation.\nPoser une question bien choisie peut renforcer votre candidature.\nPar exemple : 'Comment l'entreprise soutient-elle le développement professionnel de ses employés ?'",
    "Merci d'avoir participé à cette expérience.\nUne question pertinente à la fin peut donner une autre dimension à votre entretien.\nQue pensez-vous de demander : 'Quel est le calendrier typique pour une prise de décision concernant ce poste ?'",
    "C'était un plaisir de vous aider à vous préparer pour vos futurs entretiens.\nRappelez-vous, une bonne question de fin peut en dire long sur votre intérêt pour le poste.\nVous pourriez poser : 'Quels sont les objectifs à court et à long terme pour l'équipe/le département ?'",
    "Merci de vous être engagé dans cette simulation.\nUne question finale peut vous aider à mieux comprendre votre futur rôle.\nEssayez peut-être : 'Quel a été le parcours des personnes qui ont précédemment occupé ce poste ?'",
    "Nous avons terminé la simulation d'aujourd'hui.\nN'oubliez pas qu'une question réfléchie à la fin peut montrer que vous êtes sérieux dans votre démarche.\nUne question à envisager : 'Pouvez-vous me dire comment se passe la communication au sein de l'équipe et avec la hiérarchie ?'",
    "C'est la fin de notre simulation d'entretien.\nSe montrer curieux à la fin de l'entretien peut vous aider à en savoir plus sur l'environnement de travail.\nPourquoi ne pas demander : 'Y a-t-il des occasions pour des travaux interdépartementaux ou des collaborations avec d'autres équipes ?'",
    "Nous avons abordé de nombreux points aujourd'hui.\nUn entretien réussi est aussi une occasion d'exprimer votre propre curiosité et vos aspirations.\nUne question que vous pourriez poser : 'Comment l'entreprise encourage-t-elle l'équilibre entre la vie professionnelle et la vie privée ?'",
    "Ce fut un plaisir de simuler cet entretien avec vous.\nPoser une question judicieuse à la fin peut mettre en valeur votre réflexion et votre engagement.\nVous pourriez par exemple demander : 'Quelles technologies, outils ou approches sont actuellement utilisés dans ce rôle ?'",
    "Nous avons conclu notre session de simulation.\nGardez à l'esprit qu'une question pertinente en fin d'entretien peut faire la différence.\nUne suggestion de question : 'Y a-t-il des opportunités pour assister à des conférences, des ateliers ou d'autres événements professionnels ?'",
    "Merci d'avoir complété cette simulation.\nUne question judicieuse peut vous aider à briller en entretien.\nVous pourriez demander : 'Quels sont les indicateurs de succès pour ce poste au cours des six premiers mois ?'",
    "Nous avons fini pour aujourd'hui.\nPoser une question à la fin peut renforcer votre candidature.\nQu'en est-il de : 'Comment l'entreprise gère-t-elle l'innovation et la créativité ?'",
    "C'était enrichissant de passer ce temps avec vous.\nSouvenez-vous, une question de clôture peut en dire long sur votre sérieux.\nPar exemple : 'Comment l'entreprise gère-t-elle l'innovation et la créativité ?'",
    "La simulation est terminée.\nUne question finale peut vous aider à mieux comprendre votre futur rôle.\nVous pourriez poser : 'Quelle est la philosophie de l'entreprise en matière de développement durable ?'",
    "Merci d'avoir participé à cet simulation.\nUne question finale peut être un bon moyen de montrer votre engagement.\nVous pourriez demander : 'Quel a été un projet récemment achevé qui a eu un impact significatif sur l'entreprise ?'",
    "C'est la conclusion de notre simulation.\nPoser une question pertinente peut faire toute la différence.\nQu'en pensez-vous de : 'Y a-t-il des événements d'équipe ou des activités de team building ?'",
    "La session de simulation est terminée.\nUne question bien posée peut révéler beaucoup de votre part.\nVous pourriez par exemple demander : 'Quelle est la politique de l'entreprise en matière de télétravail ou de flexibilité des horaires ?'",
    "Nous avons couvert beaucoup de terrain aujourd'hui.\nN'oubliez pas que les questions que vous posez peuvent aussi vous aider à décider si l'entreprise vous convient.\nVous pourriez poser : 'Comment l'entreprise aborde-t-elle les évolutions et les changements dans l'industrie ?'",
    "C'est la fin de notre exercice de simulation.\nPoser une question réfléchie peut vous aider à vous démarquer.\nVous pourriez demander : 'Comment l'entreprise gère-t-elle les périodes de forte croissance ou de changement ?'"
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
