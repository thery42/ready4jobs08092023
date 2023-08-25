import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/Forum/Forum_app_scaffold.dart';
import 'package:ready4jobs/widgets/Forum/Forum_app_bar.dart';
import 'package:ready4jobs/widgets/Forum/Forum_bottom_bar.dart';
import 'package:ready4jobs/widgets/Forum/Forum_new_subject_form.dart';


class Question {
  final String title;
  int votes;
  final List<Answer> answers;

  Question(this.title) : votes = 0, answers = [];
}

class Answer {
  final String text;
  int votes;

  Answer(this.text) : votes = 0;
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Question> _questions = [];

  // Controllers for new question and answer input fields
  TextEditingController _newQuestionController = TextEditingController();
  TextEditingController _newAnswerController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _newQuestionController.dispose();
    _newAnswerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Method to add a new question
  void _addQuestion(String questionText) {
    setState(() {
      _questions.add(Question(questionText));
    });
    _newQuestionController.clear();
  }

  // Method to add a new answer to a question
  void _addAnswer(int questionIndex, String answerText) {
    setState(() {
      _questions[questionIndex].answers.add(Answer(answerText));
    });
    _newAnswerController.clear();
  }

  // Define the method to build the body
  Widget _buildBody(BuildContext context) {
    List<Question> filteredQuestions = _questions.where((question) {
      final query = _searchController.text.toLowerCase();
      return question.title.toLowerCase().contains(query);
    }).toList();

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredQuestions.length + 1, // +1 for the rules question
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Display rules question
                  return Card(
                    child: ListTile(
                      title: Text('Règles de la FAQ'),
                      subtitle: Text('Veuillez lire attentivement les règles.'),
                    ),
                  );
                }

                Question question = filteredQuestions[index - 1]; // Subtract 1 to account for rules question
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(question.title),
                        subtitle: Text('Votes: ${question.votes}'),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {
                            setState(() {
                              question.votes++;
                            });
                          },
                        ),
                      ),
                      Column(
                        children: question.answers.map((answer) {
                          return ListTile(
                            title: Text(answer.text),
                            subtitle: Text('Votes: ${answer.votes}'),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_upward),
                              onPressed: () {
                                setState(() {
                                  answer.votes++;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      // Add input fields for new questions and answers
                      TextField(
                        controller: _newAnswerController,
                        decoration: InputDecoration(
                          hintText: 'Add an answer...',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _addAnswer(index - 1, _newAnswerController.text); // Subtract 1 to account for rules question
                        },
                        child: Text('Add Answer'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to open the new subject creation form
  void _openNewSubjectForm(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewSubjectForm()));
  }

  @override
  Widget build(BuildContext context) {
    return ForumAppScaffold(
      forumCustomAppBar: ForumCustomAppBar(
        title: 'Forum',
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openNewSubjectForm(context);
            },
          ),
        ],
      ),
      forumBottomNavigationBarItemInfo: BottomNavigationBarWidget(),
      body: _buildBody(context), // Call the _buildBody method
    );
  }
}