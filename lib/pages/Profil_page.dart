  
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  
  import 'package:ready4jobs/widgets/profil/Profil_app_scaffold.dart';
  import 'package:ready4jobs/widgets/profil/Profil_app_bar.dart';
  import 'package:ready4jobs/widgets/profil/Profil_bottom_bar.dart';
  import 'package:ready4jobs/widgets/profil/Profil_picture.dart';
  import 'package:ready4jobs/widgets/profil/Profil_names.dart';
  
  import 'package:ready4jobs/widgets/profil/Profil_email.dart';
  import 'package:ready4jobs/widgets/profil/Profil_phone.dart';
  import 'package:ready4jobs/widgets/profil/Profil_address.dart';
  import 'package:ready4jobs/widgets/profil/Profil_button_sedeconnecter.dart';
  import 'package:ready4jobs/widgets/profil/Profil_button_supprimer.dart';
  import 'package:ready4jobs/widgets/profil/Profil_SettingToggle.dart';
  import 'package:ready4jobs/widgets/profil/Profil_button_contact.dart';
  import 'package:ready4jobs/widgets/profil/Profil_secteuractivite.dart';
  import 'package:ready4jobs/widgets/profil/Profil_metier.dart';
  import 'package:ready4jobs/widgets/profil/Profil_stream_builder.dart';
  import 'package:ready4jobs/widgets/profil/profil_fetcher.dart';
  import 'package:ready4jobs/widgets/profil/Profil_Button_save.dart';
  
  
  
  
  class ProfilPage extends StatefulWidget {
  
  
    @override
    _ProfilPageState createState() => _ProfilPageState();
  }
  
  class _ProfilPageState extends State<ProfilPage> {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    TextEditingController _postalCodeController = TextEditingController();
    TextEditingController _cityController = TextEditingController();
  
    ImageProvider? _imageProvider;
  
    bool _areButtonsVisible = true;
    bool _areCoordinatesVisible = true;
    bool _areRechercheVisible = true;
    bool _isModified = false;

    //bool _isMetierSelected = false;

  
    ProfileFetcher? _profileFetcher;
  
    @override
    void initState() {
      super.initState();
  
      _profileFetcher = ProfileFetcher(
          _emailController,
          _phoneController,
          _addressController,
          _postalCodeController,
          _cityController,
          nameController: _nameController,
          onImageUpdate: (updatedImage) {
            setState(() {
              _imageProvider = updatedImage;
            });
          }
      );
  
      _profileFetcher!.fetchProfile();
    }



    Widget _buildHeader() {
      final currentUser = FirebaseAuth.instance.currentUser;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the children vertically
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the children horizontally
            children: [
              /*
          ProfileSaveButton(
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
            addressController: _addressController,
            postalCodeController: _postalCodeController,
            cityController: _cityController,
          ),
          */
              Expanded(
                child: Center(
                  child: ProfilePictureWidget(
                    user: FirebaseAuth.instance.currentUser,
                    imageProvider: _imageProvider,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          NameInputWidget(controller: _nameController),
          SizedBox(height: 20),
        ],
      );
    }


    Widget _buildBody(BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildHeader(),
            Divider(color: Colors.white, thickness: 2,),

            RechercheToggleWidget(
              onToggle: () {
                setState(() {
                  _areRechercheVisible = !_areRechercheVisible;
                });
              },
              isExpanded: _areRechercheVisible,
            ),

            if (_areRechercheVisible) ...[
              Divider(color: Colors.white, thickness: 2,),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SectorDropdown(),
                    SizedBox(height: 4),
                    MetierDropdown(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],

            Divider(color: Colors.white, thickness: 2,),

            CoordinatesToggleWidget(
              onToggle: () {
                setState(() {
                  _areCoordinatesVisible = !_areCoordinatesVisible;
                });
              },
              isExpanded: _areCoordinatesVisible,
            ),

            if (_areCoordinatesVisible) ...[
              Divider(color: Colors.white, thickness: 2,),
              EmailInputWidget(controller: _emailController),
              PhoneInputWidget(controller: _phoneController),
              AddressInputWidget(
                addressController: _addressController,
                postalCodeController: _postalCodeController,
                cityController: _cityController,
              ),
              SizedBox(height: 16),
              ProfileSaveButton(  // Moved the ProfileSaveButton to this location
                nameController: _nameController,
                emailController: _emailController,
                phoneController: _phoneController,
                addressController: _addressController,
                postalCodeController: _postalCodeController,
                cityController: _cityController,
              ),
            ],

            Divider(color: Colors.white, thickness: 2,),

            SettingToggleWidget(
              onToggle: () {
                setState(() {
                  _areButtonsVisible = !_areButtonsVisible;
                });
              },
              isExpanded: _areButtonsVisible,
            ),

            Divider(color: Colors.white, thickness: 2,),

            if (_areButtonsVisible) ...[
              SizedBox(height: 16),
              LogoutButton(),
              SizedBox(height: 16),
              DeleteButton(),
              SizedBox(height: 16),
              ContactButton(),
            ],

            Divider(color: Colors.white, thickness: 2,),

          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      final currentUser = FirebaseAuth.instance.currentUser;

      return DefaultTabController(
        length: 2,  // Number of tabs
        child: ProfilAppScaffold(
          profilCustomAppBar: ProfilCustomAppBar(title: 'Mon profil'),
          profilBottomNavigationBarItemInfo: BottomNavigationBarWidget(),
          body: TabBarView(
            children: [
              ProfileStreamBuilder(
                onImageFound: (imageUrl) {
                  setState(() {
                    _imageProvider = NetworkImage(imageUrl);
                  });
                },
                buildBodyFunction: _buildBody,
              ),
              UserProfilePage(),
            ],
          ),
        ),
      );
    }
  }


