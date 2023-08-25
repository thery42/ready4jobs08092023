import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/widgets.dart';


import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class DescriptionWidget extends StatefulWidget {
  final TextEditingController controller;
  final User? user;

  DescriptionWidget({required this.controller, this.user});

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool isFocused = false;

  get downloadUrl => null;

  get uniqueFileName => null;

  void saveDescription(String description) async {
    if (widget.controller.text.isNotEmpty) {
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? user = _auth.currentUser;

        if (user != null) {
          final userId = user.uid;

          await FirebaseFirestore.instance
              .collection('description')
              .doc(userId)
              .collection('uploaded_docs')
              .add({'url': downloadUrl, 'name': uniqueFileName, 'timestamp': FieldValue.serverTimestamp() });

        }
      } catch (e) {
        print('Error saving description: $e');
      }
    }
  }

  Future<void> uploadDescriptionText(BuildContext context, String userId, String content) async {
    try {
      final storage = FirebaseStorage.instance;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final uniqueFileName = 'description_$timestamp.txt';

      print('User UID for upload: $userId'); // Print the user UID for upload

      final descriptionRef = storage.ref().child('description_text/$userId/$uniqueFileName');
      final uploadTask = descriptionRef.putString(content);
      final taskSnapshot = await uploadTask;

      print('Upload task completed successfully.'); // Print success message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Description text saved successfully!')),
      );
    } catch (e) {
      print('Error uploading description text: $e'); // Print error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while uploading description text.')),
      );
    }
  }



  void _validateAndSaveDescription() {
    setState(() {
      isFocused = false;
    });

    final descriptionContent = widget.controller.text;
    saveDescription(descriptionContent);

    print('Uploading description text...');

    if (widget.user != null) {
      uploadDescriptionText(context, widget.user!.uid, descriptionContent);
    } else {
      print('User is null, cannot upload description text.');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DESCRIPTION_CONTAINER_PADDING,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(DESCRIPTION_CONTAINER_BORDER_RADIUS),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            counterStyle: TextStyle(color: Colors.white),
          ),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: widget.controller,
              textAlign: DESCRIPTION_INPUT_TEXT_ALIGN,
              style: DESCRIPTION_INPUT_TEXT_STYLE,
              decoration: DESCRIPTION_INPUT_DECORATION.copyWith(
                contentPadding: EdgeInsets.only(top: 0.0, left: 0.0),
              ),
              maxLength: isFocused ? 200 : null,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (text) {
                setState(() {
                  isFocused = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  isFocused = false;
                  saveDescription(widget.controller.text);
                });
              },
            ),
            SizedBox(height: 16),
            Visibility(
              visible: isFocused,
              child: ElevatedButton(
                onPressed: _validateAndSaveDescription,
                child: Text('Valider'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
