import 'package:flutter/material.dart';
import 'package:ready4jobs/models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  // Créez un objet ProfileModel avec des valeurs par défaut
  ProfileModel _profile = ProfileModel(
    profilePhoto: 'assets/profile_photo.png',
    profileName: 'Frank Doe',
    profileDescription: 'Description here',
    profileEmail: 'john.doe@example.com',
    profilePhone: '123-456-7890',
    profileAddress: '123 Main St',
    profilePostalCode: '12345',
    profileCity: 'Montpellier',
    areRechercheVisible: true,
    areCoordinatesVisible: true,
    areButtonsVisible: true,
  );

  // Récupérez le profil actuel
  ProfileModel get profile => _profile;

  // Mettez à jour le profil avec de nouvelles valeurs
  void updateProfile({
    String? name,
    String? description,
    String? email,
    String? phone,
    String? address,
    String? postalCode,
    String? city,
    bool? areRechercheVisible,
    bool? areCoordinatesVisible,
    bool? areButtonsVisible,
  }) {
    // Mise à jour des propriétés si des nouvelles valeurs sont fournies
    if (name != null) _profile.profileName = name;
    if (description != null) _profile.profileDescription = description;
    if (email != null) _profile.profileEmail = email;
    if (phone != null) _profile.profilePhone = phone;
    if (address != null) _profile.profileAddress = address;
    if (postalCode != null) _profile.profilePostalCode = postalCode;
    if (city != null) _profile.profileCity = city;
    if (areRechercheVisible != null) _profile.areRechercheVisible = areRechercheVisible;
    if (areCoordinatesVisible != null) _profile.areCoordinatesVisible = areCoordinatesVisible;
    if (areButtonsVisible != null) _profile.areButtonsVisible = areButtonsVisible;

    // Notifiez les auditeurs (les widgets) que le profil a été mis à jour
    notifyListeners();
  }
}
