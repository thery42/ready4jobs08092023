import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileStreamBuilder extends StatelessWidget {
  final Function(BuildContext context) buildBodyFunction;
  final Function(String imageUrl) onImageFound;

  ProfileStreamBuilder({
    required this.buildBodyFunction,
    required this.onImageFound,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('profile_pictures')
          .doc(currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!.data() as Map<String, dynamic>?;
            if (data != null && data.containsKey('url')) {
              final imageUrl = data['url'];
              onImageFound(imageUrl);
            }
          }
          return buildBodyFunction(context);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Une erreur est survenue'));
        } else {
          return Center(child: Text('Aucune donnée disponible pour le moment'));
        }
      },
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final Stream<DocumentSnapshot> _userStream;

  UserProfilePage({Key? key})
      : _userStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue!'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Aucune donnée disponible!'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: <Widget>[
              ListTile(title: Text('Name'), subtitle: Text(userData['name'])),
              ListTile(title: Text('Email'), subtitle: Text(userData['email'])),
              ListTile(title: Text('Phone'), subtitle: Text(userData['phone'])),
              ListTile(title: Text('Address'), subtitle: Text(userData['address'])),
              ListTile(title: Text('Postal Code'), subtitle: Text(userData['postalCode'])),
              ListTile(title: Text('City'), subtitle: Text(userData['city'])),
            ],
          );
        },
      ),
    );
  }
}

class MetierStreamBuilder extends StatelessWidget {
  final Function(BuildContext context, String selectedSector) buildBodyFunction;

  MetierStreamBuilder({required this.buildBodyFunction});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('metier')
          .doc(currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("StreamBuilder: Waiting for data...");
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print("StreamBuilder: Error encountered: ${snapshot.error}");
          return Center(child: Text('Une erreur est survenue'));
        }

        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey('selectedSector')) {
            final selectedSector = data['selectedSector'];
            print("StreamBuilder: Received data for selectedSector: $selectedSector");
            return buildBodyFunction(context, selectedSector);
          }
        }

        print("StreamBuilder: No data available");
        return Center(child: Text('Aucune donnée disponible pour le moment'));
      },
    );
  }
}

