    import 'package:permission_handler/permission_handler.dart';

    class PermissionUtils {
      // Vérifie et demande la permission de stockage
      static Future<bool> requestStoragePermission() async {
        PermissionStatus status = await Permission.storage.status;
        print("Initial storage permission status: $status");

        if (!status.isGranted) {
          if (status.isPermanentlyDenied) {
            // La permission a été refusée de façon permanente
            // Rediriger l'utilisateur vers les paramètres de l'application
            openAppSettings();
            return false;
          }

          status = await Permission.storage.request();
          print("New storage permission status after request: $status");

          if (!status.isGranted) {
            return false;  // L'utilisateur a refusé la permission
          }
        }
        return true;  // Permission accordée
      }
      // Vérifie et demande la permission du microphone
        static Future<bool> requestMicrophonePermission() async {
          PermissionStatus status = await Permission.microphone.status;
          print("Initial microphone permission status: $status");

          if (!status.isGranted) {
            if (status.isPermanentlyDenied) {
              // La permission a été refusée de façon permanente
              // Rediriger l'utilisateur vers les paramètres de l'application
              openAppSettings();
              return false;
            }

            status = await Permission.microphone.request();
            print("New microphone permission status after request: $status");

            if (!status.isGranted) {
              return false;  // L'utilisateur a refusé la permission
            }
          }
          return true;  // Permission accordée
        }


    // Vous pouvez ajouter d'autres méthodes pour d'autres permissions ici, comme la caméra, le microphone, etc.
    }
