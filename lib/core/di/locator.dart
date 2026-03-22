import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../storage/local_storage.dart';
import '../../features/audio/audio_controller.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Storage
  final sharedPreferences = await SharedPreferences.getInstance();
  final localStorage = LocalStorage(sharedPreferences);
  getIt.registerSingleton<LocalStorage>(localStorage);

  // Audio Component
  final audioController = AudioController(localStorage);
  getIt.registerSingleton<AudioController>(audioController);
}
