import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/local_storage.dart';

class ScoreState {
  final int currentScore;
  final int highScore;

  const ScoreState({required this.currentScore, required this.highScore});

  ScoreState copyWith({int? currentScore, int? highScore}) {
    return ScoreState(
      currentScore: currentScore ?? this.currentScore,
      highScore: highScore ?? this.highScore,
    );
  }
}

class ScoreCubit extends Cubit<ScoreState> {
  final LocalStorage _storage;

  ScoreCubit(this._storage)
    : super(
        ScoreState(currentScore: 0, highScore: _storage.getHighScore('tap')),
      );

  void addScore(int points) {
    final newScore = state.currentScore + points;
    int newHighScore = state.highScore;

    if (newScore > newHighScore) {
      newHighScore = newScore;
      _storage.setHighScore('tap', newHighScore);
    }

    emit(state.copyWith(currentScore: newScore, highScore: newHighScore));
  }

  void resetScore() {
    emit(state.copyWith(currentScore: 0));
  }
}
