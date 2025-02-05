import 'package:audioplayers/audioplayers.dart';

class AudioServiceMomentary {
  static final AudioServiceMomentary _instance = AudioServiceMomentary._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioServiceMomentary._internal();

  static AudioServiceMomentary get instance => _instance;

  AudioPlayer get player => _audioPlayer;
  
  void dispose() {
    _audioPlayer.dispose();
  }
}