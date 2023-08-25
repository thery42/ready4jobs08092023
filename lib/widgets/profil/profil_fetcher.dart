import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ProfileFetcher {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController postalCodeController;
  final TextEditingController cityController;

  String? selectedMetier;


  final Function(ImageProvider) onImageUpdate;


  ProfileFetcher(this.emailController, this.phoneController, this.addressController, this.postalCodeController, this.cityController, {required this.nameController, required this.onImageUpdate});

  Future<void> fetchProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print("Current user UID: ${currentUser.uid}");
      // Retrieve the profile picture
      final querySnapshot = await FirebaseFirestore.instance
          .collection('profile_pictures')
          .doc(currentUser.uid)
          .collection('uploaded_docs')
          .orderBy('timestamp', descending: true)
          .get();

      final documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        final docSnapshot = documents.first;
        if (docSnapshot.exists) {
          final imageUrl = docSnapshot.data()?['url'];
          if (imageUrl != null) {
            onImageUpdate(NetworkImage(imageUrl));
          }
        }
      }

      final metierDocument = await FirebaseFirestore.instance.collection('metier').doc(currentUser.uid).get();
      if (metierDocument.exists) {
        final metierData = metierDocument.data();
        selectedMetier = metierData?['selectedSector'];
        print("Retrieved métier: $selectedMetier");
      } else {
        print("No metier document found for user ${currentUser.uid}");
      }


      // Retrieve the user's name from the "users" collection
      final userDocument = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      if (userDocument.exists) {
        final data = userDocument.data();

        // Retrieve name
        final userName = data?['name'];
        if (userName != null) {
          nameController.text = userName;
        }

        // Retrieve email
        final userEmail = data?['email'];
        if (userEmail != null) {
          emailController.text = userEmail;
        }

        // Retrieve phone
        final userPhone = data?['phone'];
        if (userPhone != null) {
          phoneController.text = userPhone;
        }

        // Retrieve address
        final userAddress = data?['address'];
        if (userAddress != null) {
          addressController.text = userAddress;
        }

        // Retrieve city
        final userCity = data?['city'];
        if (userCity != null) {
          cityController.text = userCity;
        }



        // Retrieve postal
        final userPostal = data?['postal'];
        if (userPostal != null) {
          postalCodeController.text = userPostal;
        }
      }
    }
  }
}
