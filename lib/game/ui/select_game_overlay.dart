import 'package:flutter/material.dart';

import '../my_casual_game.dart';
import 'game_card.dart';

/// Flutter overlay for game selection: horizontal scroll list of 3D game cards.
class SelectGameOverlay extends StatelessWidget {
  const SelectGameOverlay({super.key, required this.game});

  final MyCasualGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const SizedBox(height: 140),
          Spacer(),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: GameType.values.length,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, index) {
                final type = GameType.values[index];
                return GameCard(
                  gameType: type,
                  onTap: () {
                    game.selectedGameType = type;
                    game.overlays.remove('select_game');
                    game.router.pushNamed('menu');
                  },
                );
              }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 16); },
            ),
          ),
        ],
      ),
    );
  }
}
