import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/local_storage.dart';
import '../audio/audio_controller.dart';

class SettingsState {
  final bool soundEnabled;
  final bool musicEnabled;

  const SettingsState({required this.soundEnabled, required this.musicEnabled});

  SettingsState copyWith({bool? soundEnabled, bool? musicEnabled}) {
    return SettingsState(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final LocalStorage _storage;
  final AudioController _audioController;

  SettingsCubit(this._storage, this._audioController)
      : super(SettingsState(
          soundEnabled: _storage.getSoundEnabled(),
          musicEnabled: _storage.getMusicEnabled(),
        ));

  void toggleSound() {
    final newValue = !state.soundEnabled;
    _storage.setSoundEnabled(newValue);
    emit(state.copyWith(soundEnabled: newValue));
  }

  void toggleMusic() {
    final newValue = !state.musicEnabled;
    _storage.setMusicEnabled(newValue);
    _audioController.onMusicSettingChanged(newValue);
    emit(state.copyWith(musicEnabled: newValue));
  }
}
