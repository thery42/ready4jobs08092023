import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready4jobs/widgets/entretiens/Entretien_app_scaffold.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_app_bar.dart';

class EntretienDetailPage extends StatelessWidget {
  final String userId;
  final String docName;

  EntretienDetailPage({required this.userId, required this.docName});

  Future<String?> fetchImageUrl() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('entretiens')
        .doc(userId)
        .collection('uploaded_docs')
        .doc(docName)
        .get();

    String? url = docSnapshot.data()?['url'];
    print("Fetched imageUrl: $url"); // Affiche l'URL récupérée
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return EntretienAppScaffold(
      entretiensCustomAppBar: EntretiensCustomAppBar(
        title: 'Détails de l\'entretien',
      ),
      body: FutureBuilder<String?>(
        future: fetchImageUrl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur lors de la récupération de l\'image.'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            print("URL from FutureBuilder is empty or null: ${snapshot.data}");
            return Center(child: Text("Image non disponible"));
          } else {
            print("URL from FutureBuilder: ${snapshot.data}");
            return Center(child: Image.network(snapshot.data!));
          }
        },
      ),
    );
  }
}
