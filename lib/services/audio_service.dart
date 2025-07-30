import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _backgroundPlayer = AudioPlayer();

  final AudioPlayer _effectPlayer = AudioPlayer();
  final Map<String, Source> _sourcesEffect = {};
  String _sourceKeyEffect = "start";

  bool _isPreloaded = false;

  AudioService._internal() {
    configurePlayers();
    _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> configurePlayers() async {
    await _backgroundPlayer.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.none,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );

    await _effectPlayer.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          contentType: AndroidContentType.sonification,
          usageType: AndroidUsageType.assistanceSonification,
          audioFocus: AndroidAudioFocus.none,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.ambient,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );

    _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    await _backgroundPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    await _effectPlayer.setPlayerMode(PlayerMode.lowLatency); 
  }

  Future<void> preloadAudiosEffects(Map<String, String> audios) async {
    if (_isPreloaded) return;

    _sourcesEffect.clear();
    for (var entry in audios.entries) {
      _sourcesEffect[entry.key] = AssetSource(entry.value);
      _sourceKeyEffect = entry.key;
    }

    _isPreloaded = true;
  }

  Future<void> playBackground(String key) async {
    await _backgroundPlayer.play(AssetSource("sounds/background/$key.mp3"));
  }

  Future<void> playEffect(String key) async {
    if (_sourceKeyEffect != key) {
      final source = _sourcesEffect[key];
      if (source == null) return;
      await _effectPlayer.play(source);
    }
    await _effectPlayer.resume();
  }

  Future<void> stopBackground() async {
    await _backgroundPlayer.stop();
  }

  Future<void> resumeBackground() async {
    await _backgroundPlayer.resume();
  }

  Future<void> pauseBackground() async {
    await _backgroundPlayer.pause();
  }

  Future<void> playAudioSequence(List<String> audioList) async {
    for (final audioPath in audioList) {
      await _effectPlayer.play(AssetSource(audioPath));
      await _waitForAudioEnd();
    }
  }

  Future<void> _waitForAudioEnd() async {
    final completer = Completer<void>();
    void listener(PlayerState state) {
      if (state == PlayerState.completed) {
        _effectPlayer.onPlayerStateChanged.listen(null);
        completer.complete();
      }
    }
    _effectPlayer.onPlayerStateChanged.listen(listener);
    return completer.future;
  }

  Future<void> dispose() async {
    await _backgroundPlayer.dispose();
    await _effectPlayer.dispose();
  }
}
