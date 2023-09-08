import 'dart:math';

class CompetencesGeneralesQuestions {
  static final List<String> questions = [
    "Pouvez-vous partager une expérience où vous avez dû démontrer des compétences techniques essentielles pour réussir dans votre rôle professionnel ? "
        "Comment avez-vous relevé ce défi ?",
    "Parlez-nous d'une situation où vous avez dû travailler en équipe pour atteindre un objectif professionnel. Comment avez-vous collaboré avec vos collègues pour réussir ?",
    "Comment maintenez-vous vos compétences techniques à jour ? "
    "Comment avez-vous appliqué de nouvelles connaissances à votre travail quotidien ? "
        "Pouvez-vous donner un exemple ?",
    "Avez-vous déjà été confronté à un défi imprévu lors de l'exécution de vos tâches professionnelles ? "
        "Comment l'avez-vous géré et qu'avez-vous appris de cette expérience ?",
    "Décrivez comment vous priorisez et gérez votre travail lorsque vous êtes confronté à plusieurs tâches ou projets à accomplir en même temps.",
    "Comment gérez-vous les situations où vous devez prendre des décisions techniques importantes rapidement ? "
        "Pouvez-vous partager un exemple où cela s'est produit ?",
    "Pouvez-vous expliquer comment vous gérez les interactions avec des personnes qui ont des opinions différentes des vôtres dans le contexte professionnel ? "
        "Comment avez-vous résolu des désaccords ?"
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
class CompetencesSpecifiquesQuestions {
  static final List<String> questions = [
    "Décrivez comment vous avez géré une tâche complexe qui exigeait l'utilisation de compétences spécifiques à votre domaine. Comment avez-vous planifié et exécuté cette tâche ?",
    "Pouvez-vous expliquer comment vous communiquez des informations techniques ou spécialisées à des collègues ou des clients qui ont moins de connaissances dans ce domaine ?",
    "Parlez-nous d'une situation où vous avez dû apporter des améliorations à un processus ou à une méthode de travail existante. Comment avez-vous initié ces changements ?",
    "Pouvez-vous partager une expérience où vous avez dû résoudre un problème technique complexe de manière créative ? Comment avez-vous abordé ce défi et quels résultats avez-vous obtenus ?",
    "Comment adaptez-vous votre communication technique en fonction de votre public ? Pouvez-vous donner un exemple de situation où vous avez dû expliquer des concepts techniques à des non-initiés ?",
    "Avez-vous déjà dû innover ou trouver des solutions alternatives en raison de contraintes budgétaires ou de ressources limitées ? Comment avez-vous réussi à surmonter ces défis ?",
    "Parlez-nous d'une collaboration interdisciplinaire que vous avez entreprise pour résoudre un problème ou développer un projet. Comment avez-vous assuré une communication efficace entre différentes équipes ?",
    "Avez-vous déjà été chargé de former un groupe sur une nouvelle compétence technique ? Comment avez-vous abordé cette responsabilité et mesuré le succès de la formation ?",
    "Parlez-nous d'une situation où vous avez identifié une faille de sécurité potentielle dans un processus ou un système. Comment avez-vous agi pour remédier à la situation et prévenir les risques ?",
    "Comment réagissez-vous lorsque vous devez travailler avec de nouvelles technologies ou outils que vous n'avez jamais utilisés auparavant ? Pouvez-vous partager un exemple de votre capacité à apprendre rapidement ?"
  ];
}
*/