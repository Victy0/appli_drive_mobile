import 'package:audioplayers/audioplayers.dart';

class InstantAudioService {
  static final InstantAudioService _instance = InstantAudioService._internal();
  factory InstantAudioService() => _instance;

  late final AudioPlayer _player;
  final Map<String, Source> _sources = {};
  bool _isPreloaded = false;

  InstantAudioService._internal() {
    _player = AudioPlayer();
  }

  Future<void> preloadAudios(Map<String, String> audios) async {
    if (_isPreloaded) return;

    _sources.clear();
    bool isFirst = true;
    for (var entry in audios.entries) {
      _sources[entry.key] = AssetSource(entry.value);

      if (isFirst) {
        await _player.setSource(_sources.values.first);
        isFirst = false;
      }
    }

    _isPreloaded = true;
  }

  Future<void> play(String key) async {
    final source = _sources[key];
    if (source == null) return;
    await _player.stop();
    await _player.setSource(source);
    await _player.resume();
  }

  Future<void> stop() async {
    await _player.stop();
  }
}