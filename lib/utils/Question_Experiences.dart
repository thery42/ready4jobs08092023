
import 'dart:math';

class ExperiencesQuestions {
  static final List<String> questions = [
    "Comment planifiez-vous votre progression de carrière à long terme?",
    "Avez-vous refusé un emploi malgré une courte expérience précédente? Pourquoi?",
    "Comment gérez-vous le désir de changement dans votre carrière?",
    "Pouvez-vous citer un exemple d'équilibre entre engagement professionnel et engagements personnels?",
    "Avez-vous développé de nouvelles compétences pendant un emploi? Comment?",
    "Pourquoi avez-vous choisi de rester dans une entreprise plutôt que d'explorer des opportunités externes?",
    "Comment avez-vous transformé une période d'inactivité en une opportunité pour votre carrière?",
    "Comment évaluez-vous la compatibilité culturelle avec une entreprise lors d'un changement d'emploi?",
    "Pouvez-vous partager un exemple de décision professionnelle liée à la durée d'engagement dont vous avez appris?",
    "Quelle a été votre expérience la plus courte dans un emploi? Quelles en étaient les raisons?",
    "Comment gérez-vous les périodes d'adaptation lorsque vous commencez un nouvel emploi?",
    "Quelles sont les qualités essentielles que vous recherchez dans un employeur pour envisager un engagement à long terme?",
    "Pouvez-vous me parler d'une occasion où vous avez saisi une opportunité professionnelle malgré une période d'inactivité précédente?",
    "Comment envisagez-vous de contribuer à la croissance de notre entreprise en vous basant sur vos expériences précédentes?",
    "Avez-vous déjà changé d'emploi en raison de conflits au sein de l'équipe ou de la direction? Comment avez-vous géré cela?",
    "Quels sont les éléments clés que vous prenez en compte avant d'accepter une offre d'emploi?",
    "Avez-vous eu des expériences où vous avez dû jongler entre plusieurs opportunités en même temps? Comment avez-vous fait votre choix final?",
    "Comment assurez-vous une transition fluide d'un emploi à l'autre tout en restant concentré sur votre développement professionnel?",
    "Pouvez-vous citer un exemple où vous avez décidé de rester dans un poste malgré des défis, et comment cela a influencé votre croissance professionnelle?"
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
