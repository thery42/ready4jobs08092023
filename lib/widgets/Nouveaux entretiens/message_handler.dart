/*
import 'dart:math';


import 'package:ready4jobs/widgets/Nouveaux entretiens/Entretien_message.dart';
import 'package:ready4jobs/utils/Question_Introduction.dart';


import 'package:flutter/material.dart';

class MessageHandler {
  final TextEditingController messageController;
  final List<Message> messages;

  MessageHandler(this.messageController, this.messages);

  void handleSend() {
    String messageText = messageController.text;
    if (messageText.isNotEmpty) {
      messages.add(Message(messageText, true)); // Ajout du message de l'utilisateur

      // Choisir une question aléatoire depuis IntroductionQuestions
      Random rand = Random();
      int randomIndex = rand.nextInt(IntroductionQuestions.questions.length);
      String randomQuestion = IntroductionQuestions.questions[randomIndex];

      messages.add(Message(randomQuestion, false)); // Ajout de la question aléatoire

      messageController.clear();  // Nettoyez le texte du contrôleur
    }
  }


}

*/