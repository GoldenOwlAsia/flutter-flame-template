import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  static const _keySoundEnabled = 'sound_enabled';
  static const _keyMusicEnabled = 'music_enabled';
  static const _keyFirstTime = 'first_time';

  bool getSoundEnabled() => _prefs.getBool(_keySoundEnabled) ?? true;
  Future<void> setSoundEnabled(bool value) =>
      _prefs.setBool(_keySoundEnabled, value);

  bool getMusicEnabled() => _prefs.getBool(_keyMusicEnabled) ?? true;
  Future<void> setMusicEnabled(bool value) =>
      _prefs.setBool(_keyMusicEnabled, value);

  bool getFirstTime() => _prefs.getBool(_keyFirstTime) ?? true;
  Future<void> setFirstTime(bool value) => _prefs.setBool(_keyFirstTime, value);

  String _getHighScoreKey(String gameName) => 'high_score_$gameName';

  int getHighScore(String gameName) =>
      _prefs.getInt(_getHighScoreKey(gameName)) ?? 0;
  Future<void> setHighScore(String gameName, int value) =>
      _prefs.setInt(_getHighScoreKey(gameName), value);
}
