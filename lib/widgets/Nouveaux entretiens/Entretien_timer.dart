import 'dart:async';

class EntretienTimer {
  late Timer _timer;
  int remainingSeconds;
  final void Function() onTimerEnd;

  static const int maxChatDurationInMinutes = 10; // Maximum chat duration in minutes

  EntretienTimer({
    required this.onTimerEnd,
  }) : remainingSeconds = maxChatDurationInMinutes * 60 {
    _startTimer();
  }

  String get remainingTime {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Stream<String> get remainingTimeStream {
    return Stream.periodic(Duration(seconds: 1), (s) => remainingSeconds - s - 1)
        .take(remainingSeconds)
        .map((seconds) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        onTimerEnd();
        timer.cancel();
      }
    });
  }

  void restartTimer() {
    _timer.cancel();
    _startTimer();
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
