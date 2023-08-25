import 'package:speech_to_text/speech_to_text.dart';

class VoiceRecognition {
  final SpeechToText _speech = SpeechToText();

  Future<bool> initialize(Function(String) onResult) async {
    bool hasInitialized = await _speech.initialize(
      onStatus: (status) {
        print("Status of speech service: $status");
      },
    );

    if (!hasInitialized) {
      print("Speech initialization failed!");
      return false;
    }

    if (!_speech.isAvailable) {
      print("Speech recognition is not available on this platform!");
      return false;
    }

    print("Speech initialized and available!");

    _speech.listen(onResult: (result) {
      print("Recognized words: ${result.recognizedWords}");
      onResult(result.recognizedWords);
    });

    return true;
  }

  void startListening(Function(String) onResult) async {
    if (!_speech.isListening && _speech.isAvailable) {
      print("Starting to listen...");
      await _speech.listen(onResult: (result) {
        print("Recognized words while listening: ${result.recognizedWords}");
        onResult(result.recognizedWords);
      });
    } else if (!_speech.isAvailable) {
      print("Voice recognition is not available!");
    } else {
      print("Already listening!");
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      print("Stopping listening...");
      _speech.stop();
    } else {
      print("Not currently listening!");
    }
  }

  void cancelListening() {
    if (_speech.isListening) {
      print("Cancelling listening...");
      _speech.cancel();
    } else {
      print("Not currently listening!");
    }
  }
}
