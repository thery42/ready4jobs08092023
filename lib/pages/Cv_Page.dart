import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ready4jobs/widgets/cv/cv_upload_button.dart';
import 'package:ready4jobs/widgets/cv/cv_preview.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';
import 'package:ready4jobs/widgets/bottom_navigation_bar_widget.dart';

import 'package:ready4jobs/widgets/app_scaffold.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;


class CVPage extends StatefulWidget {
  @override
  _CVPageState createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  // Fields
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late User user;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  final Map<String, File> _cachedFiles = {};

  // Constants are moved to a dedicated section
  static const double DESIRED_HEIGHT = 240.0;
  static const double PREVIEW_SPACING = 20.0;
  static const double DESIRED_WIDTH = 130.0;
  static const int MAX_DOCS_TO_SHOW = 5;
  static const String ERROR_LOADING_CV_MSG = 'Une erreur s\'est produite lors du chargement du CV.';
  static const String DOWNLOADING_CV_MSG = 'Le CV est en cours de téléchargement. Veuillez patienter.';
  static const String ERROR_GENERIC_MSG = "Une erreur s'est produite";
  static const String CV_NOT_AVAILABLE_MSG = "CV non disponible ou URL invalide";

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() {
    user = _auth.currentUser!;
    _stream = _getUserResumes();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getUserResumes() {
    return _firestore
        .collection('cvs')
        .doc(user.uid)
        .collection('uploaded_docs')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  int _calculateNumberOfPreviewsInRow(double screenWidth) {
    return (screenWidth / (DESIRED_WIDTH + PREVIEW_SPACING)).floor();
  }

  Future<File?> _downloadFile(String cvUrl) async {
    if (_cachedFiles.containsKey(cvUrl)) return _cachedFiles[cvUrl];

    try {
      final dir = (await getApplicationDocumentsDirectory()).path;
      final filename = path.basename(cvUrl);
      final ref = _storage.refFromURL(cvUrl);
      final downloadUrl = await ref.getDownloadURL();
      final response = await http.get(Uri.parse(downloadUrl));
      final file = File(path.join(dir, filename));
      await file.writeAsBytes(response.bodyBytes);
      _cachedFiles[cvUrl] = file;
      return file;
    } catch (e) {
      print('Error during file download: $e');
      return null;
    }
  }

  Future<bool> _isFileDownloaded(String cvUrl) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final filename = path.basename(cvUrl);
    final file = File(path.join(dir, filename));
    return await file.exists();
  }

  Widget _buildCVPreview(String cvUrl) {
    return FutureBuilder<bool>(
      future: _isFileDownloaded(cvUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        if (snapshot.hasError || !snapshot.hasData) return Center(child: Text(ERROR_LOADING_CV_MSG));
        if (!snapshot.data!) {
          _downloadFile(cvUrl).then((file) {
            if (file != null) setState(() {});
          });
          return Center(child: Text(DOWNLOADING_CV_MSG));
        }
        return Center(
          child: SizedBox(
            width: DESIRED_WIDTH,
            height: DESIRED_HEIGHT,
            child: CvPreview(cvUrl: cvUrl),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(title: 'Mes CVs'),
      bottomNavigationBar: BottomNavigationBarWidget(),

      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Center(child: Text(ERROR_GENERIC_MSG));
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                final data = snapshot.data;
                final isEmpty = data == null || data.docs.isEmpty;
                final screenWidth = MediaQuery.of(context).size.width;
                final numberOfPreviewsInRow = _calculateNumberOfPreviewsInRow(screenWidth);
                return _buildGridView(data, isEmpty, numberOfPreviewsInRow);
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildGridView(QuerySnapshot<Map<String, dynamic>>? data, bool isEmpty, int numberOfPreviewsInRow) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberOfPreviewsInRow,
        crossAxisSpacing: PREVIEW_SPACING,
        mainAxisSpacing: PREVIEW_SPACING,
      ),
      itemCount: isEmpty ? 1 : (data!.docs.length > MAX_DOCS_TO_SHOW ? MAX_DOCS_TO_SHOW + 2 : data.docs.length + 1),
      itemBuilder: (context, index) => _buildGridViewItem(data, index, isEmpty),
    );
  }

  Widget _buildGridViewItem(QuerySnapshot<Map<String, dynamic>>? data, int index, bool isEmpty) {
    if (isEmpty || index == 0) {
      return Center(
        child: SizedBox(
          width: DESIRED_WIDTH,
          height: DESIRED_HEIGHT,
          child: CVUploadButton(user: user),
        ),
      );
    }

    if (index == MAX_DOCS_TO_SHOW + 1) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Vous avez atteint la limite de $MAX_DOCS_TO_SHOW documents.",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final docData = data!.docs[index - 1].data();
    if (!docData.containsKey('url') || !(docData['url'] is String) || (docData['url'] as String).isEmpty) {
      return Center(child: Text(CV_NOT_AVAILABLE_MSG));
    }


    final cvUrl = docData['url'] as String;
    return _buildCVPreview(cvUrl);
  }

}
