// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Casual Game';

  @override
  String get startGame => 'Start Game';

  @override
  String get settings => 'Settings';

  @override
  String get sound => 'Sound';

  @override
  String get music => 'Music';

  @override
  String score(int score) {
    return 'Score: $score';
  }

  @override
  String highScore(int score) {
    return 'High Score: $score';
  }

  @override
  String get gameOver => 'Game Over';

  @override
  String get mainMenu => 'Main Menu';
}
