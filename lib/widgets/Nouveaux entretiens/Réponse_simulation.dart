import 'package:flutter/material.dart';

class ChatSimulator {
  static const Color textColor = Colors.black; // Définir la couleur du texte ici

  static String getSimulatedResponse(String userMessage) {
    String lowerUserMessage = userMessage.toLowerCase();

    if (lowerUserMessage == "bonjour") {
      return "pourriez-vous me donner un aperçu de votre approche de travail et comment elle s'applique à ce poste ?";
    } else if (lowerUserMessage == "comment ça va ?" || lowerUserMessage == "comment allez-vous ?") {
      return "Je suis une application, donc je n'ai pas de sentiments, mais je suis là pour vous aider !";
    } else if (lowerUserMessage.contains("expérience professionnelle") || lowerUserMessage.contains("parlez-moi de votre expérience")) {
      return "Bien sûr, je serais ravi d'en savoir plus sur votre expérience professionnelle. Pouvez-vous me parler de vos emplois précédents ?";
    } else if (lowerUserMessage.contains("forces")) {
      return "C'est une excellente question. Pouvez-vous me dire quelles sont vos principales forces ou compétences ?";
    } else if (lowerUserMessage.contains("faiblesses") || lowerUserMessage.contains("points à améliorer")) {
      return "Les faiblesses sont des opportunités de croissance. Pourriez-vous partager une faiblesse que vous travaillez activement pour améliorer ?";
    } else if (lowerUserMessage.contains("parcours académique") || lowerUserMessage.contains("parlez-moi de vos études")) {
      return "Je suis intéressé par votre parcours académique. Pourriez-vous me fournir des détails sur vos études et vos réalisations ?";
    } else if (lowerUserMessage.contains("pourquoi cette entreprise ?") || lowerUserMessage.contains("pourquoi nous ?")) {
      return "Les employeurs aiment savoir pourquoi les candidats sont intéressés par leur entreprise. Pourriez-vous expliquer ce qui vous attire chez notre entreprise ?";
    } else if (lowerUserMessage.contains("où vous voyez-vous dans 5 ans ?")) {
      return "C'est une question commune en entretien. Où vous voyez-vous professionnellement dans cinq ans ?";
    } else if (lowerUserMessage.contains("avez-vous des questions pour nous ?")) {
      return "Absolument, poser des questions en entretien démontre votre intérêt. Quelles informations supplémentaires aimeriez-vous obtenir sur le poste ou l'entreprise ?";
    } else {
      return "Je ne suis pas sûr de comprendre. Pourriez-vous reformuler ou poser une question liée à l'entretien ?";
    }
  }
}
