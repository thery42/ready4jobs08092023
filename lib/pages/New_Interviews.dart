import 'package:flutter/material.dart';

import 'package:ready4jobs/services/firebase_utilities.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';


import 'package:ready4jobs/widgets/Nouveaux entretiens/NewEntretien_app_scaffold.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/NewEntretien_app_bar.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';

import 'package:ready4jobs/widgets/Nouveaux entretiens/Entretien_timer.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/Entretien_message.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/message_input.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/Entretien_end_boutton.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/Réponse_simulation.dart';



class ChatPage extends StatefulWidget {
  final User? user;
  ChatPage({Key? key, this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

String convertMessagesToText(List<Message> messages) {
  return messages.map((message) => (message.isFromUser ? "Utilisateur: " : "Application: ") + message.text).join('\n');
}

Future<void> uploadChatTextToFirebase(List<Message> messages) async {
  String chatText = convertMessagesToText(messages);


  var storageReference = FirebaseStorage.instance.ref().child('chats/${DateTime.now().toIso8601String()}.txt');

  // Upload du texte sur Firebase
  storageReference.putString(chatText);
}
class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey chatKey = GlobalKey();
  List<Message> messages = [];
  late EntretienTimer _timer;
  late Stream<String> _timerStream;

  @override
  void initState() {
    super.initState();
    _timer = EntretienTimer(onTimerEnd: _terminateChat);
    _timerStream = Stream.periodic(Duration(seconds: 1), (_) => _timer.remainingTime)
        .take(_timer.remainingSeconds);

    // Envoie du premier message de l'application
    _sendInitialMessage();
  }

  void _sendInitialMessage() {
    String appResponse = "Bonjour et bienvenue sur Ready4jobs,\n "
        "Je suis Monsieur B. ,nous allons explorer ensemble votre parcours, vos compétences et votre adéquation avec le poste visé.";

    setState(() {
      messages.add(Message(appResponse, false));
    });
  }

  void _handleSend() {
    if (_messageController.text.isNotEmpty) {
      String userMessage = _messageController.text;
      setState(() {
        messages.add(Message(userMessage, true));

        String appResponse = ChatSimulator.getSimulatedResponse(userMessage);
        messages.add(Message(appResponse, false));

        _messageController.clear();
      });
    }
  }

  void _terminateChat() {
    _timer.cancelTimer();
    uploadChatImageToFirebase(chatKey);
    uploadChatTextToFirebase(messages);
    Navigator.of(context).pop(messages);
  }

  @override
  Widget build(BuildContext context) {
    return NewEntretienAppScaffold(
      newEntretiensCustomAppBar: NewEntretiensCustomAppBar(title: 'Création d\'entretien'),   body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EntretienEndButton(onPressed: _terminateChat),
                StreamBuilder<String>(
                  stream: _timerStream,
                  initialData: _timer.remainingTime,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Durée restante : ${snapshot.data}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      );
                    } else {
                      return Text(
                        'Durée restante : ${EntretienTimer.maxChatDurationInMinutes}m',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              key: chatKey,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: messages[index].isFromUser ? Alignment.topRight : Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: messages[index].isFromUser ? kUserMessageBubbleColor : kAppMessageBubbleColor,
                        borderRadius: messages[index].isFromUser
                            ? BorderRadius.only(
                          topLeft: Radius.circular(kMessageBubbleRadius),
                          bottomLeft: Radius.circular(kMessageBubbleRadius),
                          bottomRight: Radius.circular(kMessageBubbleRadius),
                        )
                            : BorderRadius.only(
                          topRight: Radius.circular(kMessageBubbleRadius),
                          bottomRight: Radius.circular(kMessageBubbleRadius),
                          bottomLeft: Radius.circular(kMessageBubbleRadius),
                        ),
                      ),
                      child: Text(
                        messages[index].text,
                        style: TextStyle(
                          color: messages[index].isFromUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          MessageInput(
            messageController: _messageController,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancelTimer();
    super.dispose();
  }
}