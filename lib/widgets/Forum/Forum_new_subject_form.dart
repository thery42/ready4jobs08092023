import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/Forum/Forum_app_scaffold.dart';
import 'package:ready4jobs/widgets/Forum/Forum_app_bar.dart';


class NewSubjectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForumAppScaffold(
      forumCustomAppBar: ForumCustomAppBar( title: 'Create New Subject'),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your question...',
                labelText: 'Question',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to create a new subject/question
                Navigator.pop(context); // Close the form
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
