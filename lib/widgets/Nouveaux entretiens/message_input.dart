import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/voice_input.dart';
import 'package:ready4jobs/services/permission_utils.dart';


class MessageInput extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;

  MessageInput({required this.messageController, required this.onSend});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final VoiceRecognition _voiceRecognition = VoiceRecognition();

  bool _isVoiceRecognitionAvailable = false;

  @override
  void initState() {
    super.initState();
    _initialiserReconnaissanceVocale();
  }

  _initialiserReconnaissanceVocale() async {
    bool initialized = await _voiceRecognition.initialize((recognizedWords) {
      widget.messageController.text = recognizedWords;
    });

    if (initialized) {
      setState(() {
        _isVoiceRecognitionAvailable = true;
      });
    } else {
      print("Voice recognition initialization failed.");
    }
  }

  void _handleMicPress() async {
    if (!_isVoiceRecognitionAvailable) {
      print("Voice recognition is not available.");
      return;
    }

    bool hasPermission = await PermissionUtils.requestMicrophonePermission();
    if (hasPermission) {
      _voiceRecognition.startListening((recognizedWords) {
        widget.messageController.text = recognizedWords;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission du microphone refusée.'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kMessageInputPadding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.messageController,
              decoration: InputDecoration(
                fillColor: kMessageInputBackgroundColor,
                filled: true,
                hintText: kMessageInputHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kMessageInputBorderRadius),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.white,),
            onPressed: widget.onSend,
          ),
          Visibility(
            visible: _isVoiceRecognitionAvailable, // Masque l'icône lorsque la reconnaissance vocale n'est pas disponible
            child: IconButton(
              icon: Icon(Icons.mic, color: Colors.white),
              onPressed: _handleMicPress,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _voiceRecognition.stopListening();
    super.dispose();
  }
}
