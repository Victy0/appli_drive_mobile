import 'package:audioplayers/audioplayers.dart';

class AudioServiceContinuous {
  static final AudioServiceContinuous _instance = AudioServiceContinuous._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioServiceContinuous._internal() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  static AudioServiceContinuous get instance => _instance;

  AudioPlayer get player => _audioPlayer;

  void dispose() {
    _audioPlayer.dispose();
  }
}