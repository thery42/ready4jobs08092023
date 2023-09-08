import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;

  MessageInput({required this.messageController, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kMessageInputPadding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
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
            icon: Icon(Icons.send, color: Colors.white),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
