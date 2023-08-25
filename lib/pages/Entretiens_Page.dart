import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready4jobs/widgets/entretiens/Entretien_app_scaffold.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_upload_button.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_app_bar.dart';
import 'package:ready4jobs/widgets/entretiens/entretien_cover.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_bottom_bar.dart';

import 'package:ready4jobs/pages/Entretiens_Apercu_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntretiensPage extends StatefulWidget {
  @override
  _EntretiensPageState createState() => _EntretiensPageState();
}

class _EntretiensPageState extends State<EntretiensPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() {
    user = _auth.currentUser;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? _getUserEntretiens() {
    if (user == null) return null;
    return _firestore
        .collection('entretiens')
        .doc(user!.uid)
        .collection('uploaded_docs')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> naviguerVersDetailPage(BuildContext context, String userId, String nomDoc) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EntretienDetailPage(userId: userId, docName: nomDoc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building EntretiensPage'); // Ajoutez ce log pour vérifier la construction de la page
    return EntretienAppScaffold(
      entretiensCustomAppBar: EntretiensCustomAppBar(title: 'Mes Entretiens'),
      EntretiensBottomNavigationBarItemInfo: BottomNavigationBarWidget(), // Utilisez le widget ici
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    print('Building _buildBody'); // Ajoutez ce log pour vérifier la construction du corps de la page
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NavigationToEntretiensButton(),
        ),
        Expanded(
          child: user == null
              ? Center(child: Text('Veuillez vous connecter'))
              : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _getUserEntretiens(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print('StreamBuilder: No data yet'); // Ajoutez ce log pour vérifier la disponibilité des données
                return Center(child: CircularProgressIndicator());
              }

              final entretiens = snapshot.data!.docs;

              return ListView.builder(
                itemCount: entretiens.length,
                itemBuilder: (context, index) {
                  print('ListView.builder: Building item $index'); // Ajoutez ce log pour vérifier la construction des éléments de la liste
                  final entretienData = entretiens[index].data();
                  final imageUrl = entretienData['url'] ?? '';

                  print('ImageUrl in ListView.builder: $imageUrl');
                  final title = entretienData['title'] ?? 'Untitled';
                  DateTime? timestamp;
                  if (entretienData['timestamp'] is Timestamp) {
                    timestamp = (entretienData['timestamp'] as Timestamp).toDate();
                  }

                  return EntretienCover(
                    number: index + 1,
                    title: title,
                    timestamp: timestamp ?? DateTime.now(),
                    width: screenWidth * kEntretienCoverWidthFactor,
                    height: screenHeight * kEntretienCoverHeightFactor,
                    imageUrl: imageUrl,
                    onTap: () {
                      naviguerVersDetailPage(context, user!.uid, entretiens[index].id);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
