import 'dart:async';
import 'package:flame/components.dart';
import '../my_casual_game.dart';
import '../../core/di/locator.dart';
import '../../core/storage/local_storage.dart';

class LoadingRoute extends Component with HasGameReference<MyCasualGame> {
  @override
  Future<void> onLoad() async {
    add(TextComponent(text: 'Loading...', anchor: Anchor.center));

    // Simulate asset preloading here:
    // await Flame.images.loadAll(['sprite.png']);
    // await FlameAudio.audioCache.loadAll(['sfx.mp3', 'bgm.mp3']);

    await Future.delayed(const Duration(seconds: 1));
    final isFirstTime = getIt<LocalStorage>().getFirstTime();
    if (isFirstTime) {
      await game.images.load('images/landing.png');
      game.router.pushReplacementNamed('intro');
    } else {
      game.router.pushReplacementNamed('select_game');
    }
  }

  @override
  void onGameResize(Vector2 size) {
    children.whereType<TextComponent>().forEach((t) => t.position = size / 2);
    super.onGameResize(size);
  }
}
