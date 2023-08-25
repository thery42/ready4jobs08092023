import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ready4jobs/services/file_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:ready4jobs/widgets/popupMenu.dart';

import 'package:firebase_auth/firebase_auth.dart';





class CvPreview extends StatefulWidget {
  final String cvUrl;

  const CvPreview({Key? key, required this.cvUrl}) : super(key: key);

  @override
  _CvPreviewState createState() => _CvPreviewState();
}

class _CvPreviewState extends State<CvPreview> {
  String localPath = '';
  Key pdfKey = UniqueKey();
  bool cvUrlError = false;
  final TextEditingController fileNameController = TextEditingController();
  final FileManager fileManager = FileManager();
  late Future<String> fileFuture;

  @override
  void initState() {
    super.initState();
    cvUrlError = widget.cvUrl.isEmpty;
    print('CV URL: ${widget.cvUrl}'); // Print CV URL for debugging
    if (!cvUrlError) {
      fileFuture = downloadFile();
    }
  }

  Future<String> downloadFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      var downloadedPath = await fileManager.downloadFile(widget.cvUrl, destPath: directory.path)
          .timeout(const Duration(seconds: 10), onTimeout: (){
        throw TimeoutException('Le temps de téléchargement du fichier a expiré.');
      });

      if (downloadedPath != null) {
        localPath = downloadedPath;
        print('Local Path: $localPath'); // Print the value of localPath here for debugging
        return localPath;
      } else {
        // Handle the case when downloadedPath is null
        print("Error: downloadedPath is null");
        setState(() => cvUrlError = true);
        return '';
      }

    } catch (e) {
      print("Error downloading file: $e");
      setState(() => cvUrlError = true);
      if (e is TimeoutException) {
        print('TimeoutException: Le temps de téléchargement du fichier a expiré.');
      } else {
        print('Erreur de téléchargement du fichier : $e');
      }
      return '';
    }
  }


  @override
  void dispose() {
    fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print('User: $user'); // Print the user for debugging
    if (user == null) {
      return const Center(child: Text('Vous devez être connecté pour voir ce fichier.'));
    } else {
      if (cvUrlError) {
        print('Erreur: L\'URL du CV est vide ou incorrecte.');
        return const ErrorScreen();
      }
      return FutureBuilder<String>(
        future: fileFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          print('Snapshot state: ${snapshot.connectionState}'); // Print the snapshot connection state for debugging
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            if (snapshot.hasError) {
              print('Erreur lors du chargement du fichier PDF : ${snapshot.error}');
              if (snapshot.error is TimeoutException) {
                print('TimeoutException: Le temps de téléchargement du fichier a expiré.');
                return const Center(child: Text('Le temps de téléchargement du fichier a expiré.'));
              }
              return const ErrorScreen();
            } else {
              return Scaffold(
                body: Stack(
                  children: [
                    PdfScreen(localPath: snapshot.data!, pdfKey: pdfKey),
                    Positioned(
                      bottom: 106.0,
                      left: 80.0,
                      right: 0.0,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        actions: [
                          Container(
                            width: 20.0,  // Ou toute autre valeur que vous souhaitez pour la largeur
                            child: PopupMenu(
                              downloadUrl: widget.cvUrl,
                              onItemSelected: (value) {
                                print('Selected menu item: $value'); // Print the selected menu item for debugging


                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            }
          }
        },
      );
    }
  }


}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Erreur de téléchargement du CV. Veuillez réessayer.'));
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class PdfScreen extends StatelessWidget {
  final String localPath;
  final Key pdfKey;

  const PdfScreen({Key? key, required this.localPath, required this.pdfKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFView(
      key: pdfKey,
      filePath: localPath,
      autoSpacing: true,
      enableSwipe: true,
      pageSnap: true,
      swipeHorizontal: true,
      nightMode: false,
      onError: (error) => print(error.toString()),
      onRender: (_pages) => {},
      onViewCreated: (PDFViewController vc) {},
      onPageChanged: (int? page, int? total) {},
      onPageError: (page, error) {
        print('Erreur lors de l\'affichage de la page $page du PDF : $error');
      },
    );
  }
}