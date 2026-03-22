import 'package:flame/game.dart';

import 'routes/loading_route.dart';
import 'routes/intro_route.dart';
import 'routes/main_menu_route.dart';
import 'routes/select_game_route.dart';
import 'routes/gameplay_route.dart';
import 'routes/pause_route.dart';
import 'routes/game_over_route.dart';

enum GameType { tap, tap2, tap3, colorMatch }

class MyCasualGame extends FlameGame {
  late final RouterComponent router;
  int lastScore = 0;
  bool lastGameWon = false;
  GameType selectedGameType = GameType.colorMatch;

  @override
  Future<void> onLoad() async {
    images.prefix = 'assets/';
    router = RouterComponent(
      initialRoute: 'loading',
      routes: {
        'loading': Route(LoadingRoute.new),
        'intro': Route(IntroRoute.new),
        'menu': Route(MainMenuRoute.new),
        'select_game': Route(SelectGameRoute.new),
        'play': Route(GameplayRoute.new),
        'pause': Route(PauseRoute.new),
        'game_over': Route(GameOverRoute.new),
      },
    );
    add(router);
  }
}
