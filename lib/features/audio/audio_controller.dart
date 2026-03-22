import 'package:flame_audio/flame_audio.dart';
import '../../core/storage/local_storage.dart';

class AudioController {
  final LocalStorage _storage;
  String? _currentBgm;

  AudioController(this._storage);

  void playSfx(String filename) {
    if (_storage.getSoundEnabled()) {
      FlameAudio.play(filename);
    }
  }

  void playBgm(String filename) {
    _currentBgm = filename;
    if (_storage.getMusicEnabled()) {
      FlameAudio.bgm.play(filename);
    }
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  void onMusicSettingChanged(bool isEnabled) {
    if (isEnabled && _currentBgm != null) {
      FlameAudio.bgm.play(_currentBgm!);
    } else {
      FlameAudio.bgm.stop();
    }
  }
}
