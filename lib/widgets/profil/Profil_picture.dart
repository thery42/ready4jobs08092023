import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ready4jobs/widgets/profil/Profil_constants.dart';
import 'package:ready4jobs/widgets/profil/Profil_firebase_service.dart';

class ProfilePictureWidget extends StatefulWidget {
  final ImageProvider? imageProvider;
  final VoidCallback? onUpdate;
  final User? user;

  ProfilePictureWidget({this.imageProvider, this.onUpdate, this.user});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  ImageProvider? _imageProvider;
  bool _hasSelectedImage = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<File?> getCachedProfilePicture(String fileName) async {
    final cacheDir = await getTemporaryDirectory();
    final cachedFile = File('${cacheDir.path}/$fileName');

    if (await cachedFile.exists()) {
      // Vérifie si le cache est ancien et, dans ce cas, le supprime.
      final cacheCreationDate = await cachedFile.lastModified();
      final durationSinceCache = DateTime.now().difference(cacheCreationDate);
      if (durationSinceCache > Duration(days: 7)) {  // Cache plus vieux que 7 jours
        await cachedFile.delete();
        return null;
      }
      return cachedFile;
    }
    return null;
  }

  Future<File> cacheProfilePicture(File imageFile, String fileName) async {
    final cacheDir = await getTemporaryDirectory();
    final targetFile = File('${cacheDir.path}/$fileName');

    // Copie l'image dans le cache
    return imageFile.copy(targetFile.path);
  }


  Future<void> _loadProfilePicture() async {
    if (widget.imageProvider != null) {
      _imageProvider = widget.imageProvider;
      _hasSelectedImage = _imageProvider != null;
    } else if (widget.user != null) {
      final uniqueFileName = 'profile_${widget.user!.uid}.jpg';

      final cachedProfilePicture = await getCachedProfilePicture(uniqueFileName);
      if (cachedProfilePicture != null && !_isDisposed) {
        setState(() {
          _imageProvider = FileImage(cachedProfilePicture);
          _hasSelectedImage = true;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageProvider = FileImage(File(image.path));
        _hasSelectedImage = true;
      });

      if (widget.user != null) {
        final uniqueFileName = 'profile_${widget.user!.uid}.jpg';

        FirebaseService.deletePreviousProfilePicture(context, widget.user!.uid);
        await FirebaseService.deleteProfilePictureFromFirestore(widget.user!.uid);

        FirebaseService.uploadProfilePicture(context, File(image.path), widget.user!.uid);

        await cacheProfilePicture(File(image.path), uniqueFileName);
      } else {
        print("No authenticated user found.");
      }
    } else {
      print("Image selection canceled.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (_imageProvider != null)
            CircleAvatar(
              radius: kAvatarRadius,
              backgroundImage: _imageProvider,
            ),
          Padding(
            padding: kIconPadding,
            child: Icon(
              _hasSelectedImage ? Icons.camera_alt : Icons.camera_alt,
              color: kIconColor,
              size: kIconSize,
            ),
          )
        ],
      ),
    );
  }
}