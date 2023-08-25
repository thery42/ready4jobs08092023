  class ProfileModel {
    String profilePhoto; // profilePhoto is now nullable
    String profileName;
    String profileDescription;
    String profileEmail;
    String profilePhone;
    String profileAddress;
    String profilePostalCode;
    String profileCity;
    bool areRechercheVisible;
    bool areCoordinatesVisible;
    bool areButtonsVisible;

    ProfileModel({
      required this.profilePhoto,
      required this.profileName,
      required this.profileDescription,
      required this.profileEmail,
      required this.profilePhone,
      required this.profileAddress,
      required this.profilePostalCode,
      required this.profileCity,
      required this.areRechercheVisible,
      required this.areCoordinatesVisible,
      required this.areButtonsVisible,
    });
  }
