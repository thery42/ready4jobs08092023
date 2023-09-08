import 'package:flutter/material.dart';
import 'package:ready4jobs/utils/Question_Introduction.dart';
import 'package:ready4jobs/utils/Question_compétences.dart';

import 'package:ready4jobs/utils/Cv_Question_compétences.dart';
import 'package:ready4jobs/utils/Question_Experiences.dart';
import 'package:ready4jobs/utils/Cv_Question_Experiences.dart';

import 'package:ready4jobs/utils/Question_Motivation.dart';
import 'package:ready4jobs/utils/Question_candidat.dart';

import 'package:ready4jobs/utils/Question_comportement.dart';




class ChatSimulator {
  static const Color textColor = Colors.black;

  static bool askingIntroductionQuestion = true;
  static bool askingGeneralQuestions = false;
  static bool userAnswered = false; // Track if the user has answered the first question in CompetencesGeneralesQuestions

  static bool introductionDone = false; // Ajoutez cette variable pour suivre si l'introduction est terminée
  static bool firstCompetenceQuestionDone = false; // Ajoutez cette variable pour suivre si la première question de compétence est terminée
  static bool secondCompetenceQuestionDone = false; // Ajoutez cette variable pour suivre si la deuxième question de compétence est terminée
  static bool competenceQuestionsCvDone = false; // Ajoutez cette variable pour suivre si les questions de compétences CV sont terminées
  static bool firstExperienceQuestionDone = false; // Ajoutez cette variable pour suivre si la première question d'expérience est terminée
  static bool secondExperienceQuestionDone = false; // Ajoutez cette variable pour suivre si la deuxième question d'expérience est terminée
  static bool experiencesQuestionsCvDone = false; // Ajoutez cette variable pour suivre si les questions d'expériences CV sont terminées
  static bool comportementQuestionsDone = false; // Ajoutez cette variable pour suivre si les questions de comportement sont terminées
  static bool motivationQuestionsDone = false; // Ajoutez cette variable pour suivre si les questions de motivation sont terminées
  static bool candidatQuestionsDone = false; // Ajoutez cette variable pour suivre si les questions de candidat sont terminées

  static String getSimulatedResponse(String userMessage) {
    if (!introductionDone) {
      introductionDone = true; // Marquez l'introduction comme terminée après la première question
      return IntroductionQuestions.getRandomQuestion();
    } else if (!firstCompetenceQuestionDone) {
      firstCompetenceQuestionDone = true; // Marquez la première question de compétence comme terminée après la première réponse
      return CompetencesGeneralesQuestions.getRandomQuestion();
    } else if (!secondCompetenceQuestionDone) {
      secondCompetenceQuestionDone = true; // Marquez la deuxième question de compétence comme terminée après la première réponse
      return CompetencesGeneralesQuestions.getRandomQuestion();
    } else if (!competenceQuestionsCvDone) {
      competenceQuestionsCvDone = true; // Marquez les questions de compétences CV comme terminées après la première réponse
      return CompetencesQuestionsCv.getRandomQuestion(); // Ajoutez ici la question de CompetencesQuestionsCv
    } else if (!firstExperienceQuestionDone) {
      firstExperienceQuestionDone = true; // Marquez la première question d'expérience comme terminée après la première réponse
      return ExperiencesQuestions.getRandomQuestion(); // Ajoutez ici la première question de ExperiencesQuestions
    } else if (!secondExperienceQuestionDone) {
      secondExperienceQuestionDone = true; // Marquez la deuxième question d'expérience comme terminée après la première réponse
      return ExperiencesQuestions.getRandomQuestion(); // Ajoutez ici la deuxième question de ExperiencesQuestions
    } else if (!experiencesQuestionsCvDone) {
      experiencesQuestionsCvDone = true; // Marquez les questions d'expériences CV comme terminées après la première réponse
      return ExperiencesQuestionsCv.getRandomQuestion(); // Ajoutez ici la question de ExperiencesQuestionsCv
    } else if (!comportementQuestionsDone) {
      comportementQuestionsDone = true; // Marquez les questions de comportement comme terminées après la première réponse
      return ComportementQuestions.getRandomQuestion(); // Ajoutez ici la question de ComportementQuestions
    } else if (!motivationQuestionsDone) {
      motivationQuestionsDone = true; // Marquez les questions de motivation comme terminées après la première réponse
      return MotivationQuestions.getRandomQuestion(); // Ajoutez ici la question de MotivationQuestions
    } else if (!candidatQuestionsDone) {
      candidatQuestionsDone = true; // Ajoutez cette variable pour suivre si les questions de candidat sont terminées
      return CandidatQuestions.getRandomQuestion(); // Ajoutez ici la question de CandidatQuestions
    } else {
      // Ignorer les réponses du candidat une fois que les questions de candidat sont terminées
      return "Merci pour vos réponses. L'entretien est maintenant terminé.";
    }
  }
}
